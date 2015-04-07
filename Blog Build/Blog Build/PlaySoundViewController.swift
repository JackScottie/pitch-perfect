//
//  PlaySoundViewController.swift
//  Blog Build
//
//  Created by Jack on 3/24/15.
//  Copyright (c) 2015 Jack. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {
    var AudioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
        
        //code from thiago_243118
        //This piece of code sets the sound to always play on the Speakers
        let session = AVAudioSession.sharedInstance()
        var error: NSError?
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: &error)
        session.overrideOutputAudioPort(AVAudioSessionPortOverride.Speaker, error: &error)
        session.setActive(true, error: &error)
        // end code from thiago_243118
        
        
        AudioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        AudioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func AdvancedSettingActionButton(sender: UIButton) {
         performSegueWithIdentifier("ToAdvancedSettings", sender: receivedAudio)
        AudioPlayer.currentTime = 0.0
        AudioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "ToAdvancedSettings"){
            let SliderPlayVC:SliderPlayViewController = segue.destinationViewController as SliderPlayViewController
            let data = sender as RecordedAudio
            SliderPlayVC.receivedAudio = data
        }
    }

    
    @IBAction func Rabbit_Fast(sender: UIButton) {
        AudioPlayer.currentTime = 0.0
        audioEngine.stop()
        AudioPlayer.rate = 1.5
        
        AudioPlayer.play()
    }
    
    @IBAction func Snail_Slow(sender: UIButton) {
        AudioPlayer.currentTime = 0.0
        audioEngine.stop()
        audioEngine.reset()
        AudioPlayer.rate = 0.5
        AudioPlayer.play()
        
    }

    @IBAction func Stop_Action_Button(sender: UIButton) {
        AudioPlayer.currentTime = 0.0
        AudioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
    }
    
    @IBAction func Chipmunk_Action_Button(sender: UIButton) {
        playAudioWithVariablePitch(1000)
     
        
    }
    
    @IBAction func DarthVader_Action_Button(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
     
    }
    
    
    func playAudioWithVariablePitch(pitch: Float){
        AudioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
