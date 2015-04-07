//
//  SliderPlayViewController.swift
//  Blog Build
//
//  Created by Jack on 3/31/15.
//  Copyright (c) 2015 Jack. All rights reserved.
//

import UIKit
import AVFoundation

class SliderPlayViewController: UIViewController {
    var SpeedSliderValue:Float!
    var PitchSliderValue:Float!
    var EchoSliderValue:Float!
    var AudioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        SpeedSliderValue = 1.0
        PitchSliderValue = 1.0
        EchoSliderValue = 0.0
        
        AudioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        AudioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func SpeedSlider(sender: UISlider) {
        SpeedSliderValue = sender.value
        playAudioWithVariablePitch(PitchSliderValue, speed: SpeedSliderValue, echo: EchoSliderValue)

        


    }
    
    @IBAction func PitchSlider(sender: UISlider) {
        PitchSliderValue = sender.value
        playAudioWithVariablePitch(PitchSliderValue, speed: SpeedSliderValue, echo: EchoSliderValue)

    }
    
    
    @IBAction func EchoSlider(sender: UISlider) {
        EchoSliderValue = sender.value
        playAudioWithVariablePitch(PitchSliderValue, speed: SpeedSliderValue, echo:EchoSliderValue)
    }
    
    func playAudioWithVariablePitch(pitch: Float, speed: Float, echo: Float){
        AudioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        
        var changeBothEffects = AVAudioUnitTimePitch()
        changeBothEffects.pitch = pitch
        changeBothEffects.rate = speed
        audioEngine.attachNode(changeBothEffects)
 
        var reverb = AVAudioUnitReverb()
        reverb.wetDryMix = echo
        audioEngine.attachNode(reverb)

        
        audioEngine.connect(audioPlayerNode, to: changeBothEffects, format: nil)
        audioEngine.connect(changeBothEffects, to: reverb, format: nil)
        audioEngine.connect(reverb, to: audioEngine.mainMixerNode, format: nil)

       
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
      
        audioEngine.startAndReturnError(nil)
      
        audioPlayerNode.play()
   }

    
    @IBAction func Play_Slider_Action(sender: UIButton) {
        playAudioWithVariablePitch(PitchSliderValue, speed: SpeedSliderValue, echo: EchoSliderValue)
    }
    
    @IBAction func Stop_Slider_Action(sender: UIButton) {
        AudioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
    
    @IBAction func Snail_Play(sender: UIButton) {
        playAudioWithVariablePitch(PitchSliderValue, speed: SpeedSliderValue, echo: EchoSliderValue)
    }
    
    @IBAction func Rabbit_Play(sender: UIButton) {
        playAudioWithVariablePitch(PitchSliderValue, speed: SpeedSliderValue, echo: EchoSliderValue)
    }
    
    @IBAction func Darth_Play(sender: UIButton) {
        playAudioWithVariablePitch(PitchSliderValue, speed: SpeedSliderValue, echo: EchoSliderValue)
    }
    
    @IBAction func Squirrel_Play(sender: UIButton) {
        playAudioWithVariablePitch(PitchSliderValue, speed: SpeedSliderValue, echo: EchoSliderValue)
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
