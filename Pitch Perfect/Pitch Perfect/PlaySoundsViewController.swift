//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Peter Sun on 3/31/15.
//  Copyright (c) 2015 Psun. All rights reserved.
//

import UIKit
import AVFoundation


class PlaySoundsViewController: UIViewController {

    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    
    @IBAction func playFastAudio(sender: AnyObject) {
        playFromBegin(1.5)
    }
    
    @IBAction func playSlowAudio(sender: AnyObject) {
        playFromBegin(0.5)
    }
    
    @IBAction func playChipmunkAudio(sender: AnyObject) {
        playAudioWithVariablePitch(1000.0)
    }
    
    @IBAction func playDarthvaderAudio(sender: AnyObject) {
        playAudioWithVariablePitch(-1000.0)
    }
    
    
    @IBAction func stopPlay(sender: AnyObject) {
        stopAudioPlayerAndAudioEngine()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        
        // Convert NSURL to AVAudioFile
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

   
    func playFromBegin(rate: Float) {
        stopAudioPlayerAndAudioEngine()
        
        audioPlayer.rate = rate
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        stopAudioPlayerAndAudioEngine()
        
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
    
    
   
    func stopAudioPlayerAndAudioEngine() {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
}

