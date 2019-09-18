//
//  AppDelegate.swift
//  AlarmClock
//
//  Created by lieon on 2019/9/16.
//  Copyright © 2019 lieon. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configRootVC()
        return true
    }
    
}

extension AppDelegate {
    fileprivate func configRootVC() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = HomeViewController()
        window?.makeKeyAndVisible()
    }
}
