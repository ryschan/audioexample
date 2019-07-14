//
//  ViewController.swift
//  AVBasicPlayback
//
//  Created by Ryan Schanberger on 6/23/19.
//  Copyright © 2019 schanberger. All rights reserved.
//

import UIKit
import AVFoundation



class ViewController: UIViewController {

    var player = AVPlayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func playPressed(_ sender: Any) {
        
        guard let url = URL(string: "https://firebasestorage.googleapis.com/v0/b/itero-a1e4b.appspot.com/o/Test%20Audio.mp3?alt=media&token=ff8dbdcc-1136-4e3c-a24c-ccc4d098dea7") else {return}
        let playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        player.play()
    }
        

    
    func handleConnectionError(error: Error) {
        //standard ios alert
        let alert = UIAlertController(title: "Error!", message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func generalAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}


