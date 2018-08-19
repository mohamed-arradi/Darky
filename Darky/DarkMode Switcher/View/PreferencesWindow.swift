//
//  PreferencesWindow.swift
//  WeatherBar
//
//  Created by Brad Greenlee on 10/13/15.
//  Copyright © 2015 Etsy. All rights reserved.
//

import Cocoa
import LoginServiceKit

protocol PreferencesWindowDelegate {
    func preferencesDidUpdate()
}

class PreferencesWindow: NSWindowController, NSWindowDelegate {
    
    var delegate: PreferencesWindowDelegate?
    @IBOutlet weak var startUpCheckbox: NSButton!

    fileprivate  let appPath = Bundle.main.bundlePath
    
    override var windowNibName: NSNib.Name? {
        return NSNib.Name(rawValue: "PreferencesWindow")
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()

        self.window?.center()
        self.window?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
        
        self.window?.title = "settings".localized
        
        detectStartUpOption()
    }
    
    func windowWillClose(_ notification: Notification) {
        delegate?.preferencesDidUpdate()
    }
    
    fileprivate func detectStartUpOption() {
        
        let isStartupOnLogin = LoginServiceKit.isExistLoginItems(at: appPath)
   
        startUpCheckbox.state = isStartupOnLogin == true ? .on : .off
        startUpCheckbox.title = "enable_start_up_login".localized
    }
    
    @IBAction func removeAppFromLaunch(sender: Any) {
        
        let isStartupOnLogin = LoginServiceKit.isExistLoginItems(at: appPath)
        
        if isStartupOnLogin == true {
            LoginServiceKit.removeLoginItems(at: appPath)
        } else {
            LoginServiceKit.addLoginItems(at: appPath)
        }
        
        detectStartUpOption()
    }
}
