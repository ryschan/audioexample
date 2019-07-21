//
//  Extensions.swift
//  AVBasicPlayback
//
//  Created by Ryan Schanberger on 7/20/19.
//  Copyright © 2019 schanberger. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
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
