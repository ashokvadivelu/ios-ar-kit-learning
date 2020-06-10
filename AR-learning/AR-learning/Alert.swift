//
//  Alert.swift
//  AR-learning
//
//  Created by Ashok on 07/06/20.
//  Copyright © 2020 ashok. All rights reserved.
//
import UIKit
import Foundation
struct Alert {
    func show(_ message: String, _ currentView: UIViewController) {
        let alert = UIAlertController(title: "Info", message: message, preferredStyle: UIAlertController.Style.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        // show the alert
        currentView.present(alert, animated: true, completion: nil)
    }
}
