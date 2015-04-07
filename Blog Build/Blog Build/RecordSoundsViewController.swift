//
//  RecordSoundsViewController.swift
//  Blog Build
//
//  Created by Jack on 3/24/15.
//  Copyright (c) 2015 Jack. All rights reserved.
// check

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    var audioRecorder:AVAudioRecorder!
    var recordedAudio: RecordedAudio!

    override func viewDidLoad() {
        super.viewDidLoad()
        Stop_Outlet_Button.hidden = true
        Recording_Label_Outlet.hidden = true
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBOutlet weak var Microphone_Outlet: UIButton!
    @IBOutlet weak var Recording_Label_Outlet: UILabel!
    @IBOutlet weak var Stop_Outlet_Button: UIButton!
    @IBOutlet weak var Instructions_Outlet: UILabel!

    @IBAction func Microphone_Action_Button(sender: UIButton) {
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]

        
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
        Instructions_Outlet.hidden = true
        Microphone_Outlet.enabled = false
        Recording_Label_Outlet.hidden = false
        Stop_Outlet_Button.hidden = false
        println("check, check")
        
    }
  

        func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
            if(flag){
                recordedAudio = RecordedAudio()
                recordedAudio.filePathUrl = recorder.url
                recordedAudio.title = recorder.url.lastPathComponent
                performSegueWithIdentifier("stopRecording", sender: recordedAudio)
            }
            else{
                println("Something is wrong.")
                Microphone_Outlet.enabled = true
                Recording_Label_Outlet.hidden = true
                Stop_Outlet_Button.hidden = true
            }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording"){
        let playSoundsVC:PlaySoundViewController = segue.destinationViewController as PlaySoundViewController
        let data = sender as RecordedAudio
        playSoundsVC.receivedAudio = data
    }
    }
    


    @IBAction func Stop_Action_Button(sender: UIButton) {
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
        
        Instructions_Outlet.hidden = false
        Microphone_Outlet.enabled = true
        Recording_Label_Outlet.hidden = true
        Stop_Outlet_Button.hidden = true
        
    }

}

