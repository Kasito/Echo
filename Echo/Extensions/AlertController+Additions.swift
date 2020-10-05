//
//  View.swift
//  Echo
//
//  Created by Kasito on 05.10.2020.
//

import UIKit


extension UIAlertController {
    class func create(with title: String, message: String? = nil) -> UIAlertController {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertView.addAction(action)
        return alertView
    }
    
}
