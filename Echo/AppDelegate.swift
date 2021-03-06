//
//  AppDelegate.swift
//  Echo
//
//  Created by Kasito on 21.09.2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var factory: Coordinator!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let factory = Coordinator(window: window)
        factory.makeLogin()
        
        return true
    }
}
