//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Hlias Giannoulis on 3/10/15.
//  Copyright (c) 2015 Hlias Giannoulis. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController,AVAudioRecorderDelegate {
    

    @IBOutlet weak var RecordingLabel: UILabel!
    @IBOutlet weak var stopButton:UIButton!
    @IBOutlet weak var recordButton:UIButton!
    @IBOutlet weak var TaptoRecordLabel: UILabel!
    
    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
 
    }


    override func viewWillAppear(animated: Bool) {
        stopButton.hidden=true
        recordButton.enabled=true
        RecordingLabel.hidden=true
        TaptoRecordLabel.hidden=false
    }

    
    @IBAction func recordAudio(sender: UIButton) {
        RecordingLabel.hidden=false
        stopButton.hidden=false
        recordButton.enabled=false
        TaptoRecordLabel.hidden=true
        
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
    }
    

    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        
        if(flag){
            
            recordedAudio = RecordedAudio(filePathUrl : recorder.url, title : recorder.url.lastPathComponent)
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        }else{
            println("Recording was not successful")
            recordButton.enabled = true;
            stopButton.hidden = true;
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording") {
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as PlaySoundsViewController
            let data = sender as RecordedAudio
            playSoundsVC.receivedAudio = data
        }
        
    }
    

    @IBAction func stopAudio(sender: UIButton) {
        RecordingLabel.hidden=true
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
        
    }
    
    
    
    
    
    

}

