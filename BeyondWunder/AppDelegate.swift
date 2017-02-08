//
//  AppDelegate.swift
//  BeyondWunder
//
//  Created by hoemoon on 07/02/2017.
//  Copyright © 2017 hoemoon. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        let defaults = UserDefaults.standard
        let isLogin = defaults.object(forKey: "isLogin")! as? Bool ?? Bool()
        
        if isLogin == true {
            print(isLogin)
            window?.rootViewController = TaskListViewController()
        } else {
            window?.rootViewController = UINavigationController(rootViewController: StartViewController())
        }
        window?.makeKeyAndVisible()
        
//        print("IS LOGIN",defaults.object(forKey: "isLogin"))
        
        return true
    }

}

