//
//  AppDelegate.swift
//  懂我
//
//  Created by Start on 5/10/15.
//  Copyright (c) 2015 Ancun. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        application.setStatusBarHidden(false, withAnimation: UIStatusBarAnimation.Fade)
        application .setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
        self.window=UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window?.rootViewController=ViewController()
        self.window?.backgroundColor=UIColor.whiteColor()
        self.window?.makeKeyAndVisible()
        
        return true
    }


}

