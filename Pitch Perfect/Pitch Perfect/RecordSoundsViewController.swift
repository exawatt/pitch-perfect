//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Peter Sun on 3/18/15.
//  Copyright (c) 2015 Psun. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    var audioRecorder: AVAudioRecorder!
    var recordedAudio: RecordedAudio!
  
   
    @IBOutlet weak var labelRecording: UILabel!
    @IBOutlet weak var buttonStop: UIButton!
    @IBOutlet weak var buttonRecord: UIButton!

    
    @IBAction func recordAudio(sender: UIButton) {
        
        labelRecording.text = "Recording"
        buttonStop.hidden = false
        buttonRecord.enabled = false    
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        var currentDateTime = NSDate()
        var formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        var recordingName = formatter.stringFromDate(currentDateTime) + ".wav"
        var pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
       
        println(filePath)
        
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true;
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
        
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        
        if(flag) {
            //Save the recorded audio
            recordedAudio = RecordedAudio(filePathUrl: recorder.url, title: recorder.url.lastPathComponent! )
        
            //Move to the next scene aka perform seque
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        } else {
        
            labelRecording.text = "Recording was not successful"
            println("Recording was not successful")
            buttonRecord.enabled = true
            buttonStop.hidden = true
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording") {
            let playSoundsVC: PlaySoundsViewController = segue.destinationViewController as PlaySoundsViewController

            let data = sender as RecordedAudio
            playSoundsVC.receivedAudio = data           
            
        }
        
    }
    
    
    @IBAction func stopRecord(sender: UIButton) {
        
        labelRecording.text = "Recording complete"
        buttonStop.hidden = true
        buttonRecord.enabled = true
        
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
        
    }

   

    override func viewWillAppear(animated: Bool) {
        labelRecording.text = "Tap Microphone To Record"
        buttonStop.hidden = true
        buttonRecord.enabled = true
    }

   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelRecording.text = "Tap To Record"
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

