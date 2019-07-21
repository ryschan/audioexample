//
//  ViewController.swift
//  AVBasicPlayback
//
//  Created by Ryan Schanberger on 6/23/19.
//  Copyright © 2019 schanberger. All rights reserved.
//

import UIKit
import AVFoundation
import SystemConfiguration

class ViewController: UIViewController {

    var player = AudioPlayerWorker()
    let reachability = SCNetworkReachabilityCreateWithName(nil, "www.google.com")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkReachable()
    }

    @IBAction func playPressed(_ sender: Any) {
       checkReachable()
        guard let url = URL(string: "https://firebasestorage.googleapis.com/v0/b/itero-a1e4b.appspot.com/o/Test%20Audio.mp3?alt=media&token=ff8dbdcc-1136-4e3c-a24c-ccc4d098dea7") else {return}
        
        let playerItem = AVPlayerItem(url: url)
        player.play(with: url)
    }
    
    @IBAction func pausePressed(_ sender: Any) {
        player.pause()
    }
    
    
    func checkReachable() {
        var flags = SCNetworkReachabilityFlags()
        SCNetworkReachabilityGetFlags(self.reachability!, &flags)

        if (isNetworkReachable(with: flags))
        {
            print (flags)
            if flags.contains(.isWWAN) {
                // self.alert(message: "via mobile", title: "Reachable")
                print ("reachable via mobile")
                return
            }
            //self.alert (message: "vi wifi", title "Reachable")
            print ("reachable via wifi")
        }
        else if (!isNetworkReachable(with: flags)){
            //HOW CAN WE CHECK TO SEE IF AUDIO IS PLAYING SO IF THERE IS NO INTERNET CONNECTION BUT AUDIO IS PLAYING AN ALERT DOES NOT POP UP?
            generalAlert(title: "Error!", message: "Not connected to Internet.")
            print (flags)
            print ("not reachable!")
            return
        }
    }

        func isNetworkReachable (with flags: SCNetworkReachabilityFlags) -> Bool {
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        let canConnectAutomatically = flags.contains(.connectionOnDemand) || flags.contains(.connectionOnTraffic)
        let canConnectWuthoutUserInteraction = canConnectAutomatically && !flags.contains(.interventionRequired)
        return isReachable && (!needsConnection || canConnectWuthoutUserInteraction)
    }

}
