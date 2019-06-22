//
//  AppDelegate.swift
//  DarkMode Switcher
//
//  Created by Mohamed Arradi on 6/9/18.
//  Copyright © 2018 Mohamed ARRADI. All rights reserved.
//

import Cocoa
import ServiceManagement
import LoginServiceKit

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        let app = Bundle.main.bundlePath
        
        if LoginServiceKit.isExistLoginItems(at: app) == false {
            LoginServiceKit.addLoginItems(at: app)
        }
    }
}

