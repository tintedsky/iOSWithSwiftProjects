//
//  ViewController.swift
//  Scribe-SpeechRecognationExample
//
//  Created by Berkant Y. GEDIZ on 6/18/17,25.
//  Copyright © 2017 Mnemosyne C2. All rights reserved.
//

import UIKit
import Speech
import AVFoundation

class MainVC: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    @IBOutlet weak var transcriptionTextField: UITextView!
    
    var audioPlayer: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        activitySpinner.isHidden = true
        
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        player.stop()
        activitySpinner.stopAnimating()
        activitySpinner.isHidden = true
    }
    
    func requestSpeechAuth() {
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            if authStatus == SFSpeechRecognizerAuthorizationStatus.authorized {
                if let path = Bundle.main.url(forResource: "test", withExtension: "m4a") {
                    do {
                        let sound = try AVAudioPlayer(contentsOf: path)
                        self.audioPlayer = sound
                        self.audioPlayer.play()
                        self.audioPlayer.delegate = self
                    } catch {
                        print("Error!")
                    }
                    
                    let recognizer = SFSpeechRecognizer()
                    let request = SFSpeechURLRecognitionRequest(url: path)
                    
                    recognizer?.recognitionTask(with: request) { (result, error) in
                        if let error = error  {
                            print("There was an error \(error)")
                        } else {
                            self.transcriptionTextField.text = result?.bestTranscription.formattedString ?? "Error"
                        }
                    }
                }
            }
        }
    }

    @IBAction func playBtnPressed(_ sender: UIButton) {
        activitySpinner.isHidden = false
        activitySpinner.startAnimating()
        self.requestSpeechAuth()
    }

}

