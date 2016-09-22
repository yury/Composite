//
//  AppDelegate.swift
//  Composite
//
//  Created by Yury Korolev on 9/22/16.
//  Copyright © 2016 anjlab. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = ViewController()
        
        window?.makeKeyAndVisible()
        
        return true
    }


}

