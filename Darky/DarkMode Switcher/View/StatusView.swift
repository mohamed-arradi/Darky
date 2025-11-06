//
//  SettingsView.swift
//  DarkMode Switcher
//
//  Created by Mohamed Arradi on 6/11/18.
//  Copyright © 2018 Mohamed ARRADI. All rights reserved.
//

import Foundation
import LoginServiceKit

class StatusView: NSView {
    
    @IBOutlet weak var darkModeOnButton: NSButton!
    @IBOutlet weak var darkModeOffButton: NSButton!
    @IBOutlet weak var startUpCheckbox: NSButton!
    
    weak var statusMenu: NSMenu?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.darkModeOnButton.title = "activate_dark_mode".localized
        self.darkModeOffButton.title = "activate_light_mode".localized
        
        detectDarkMode()
        detectStartUpOption()
    }
    
    @objc func detectDarkMode() {
        
        guard let darkMode =  AppleScriptHelper.getValueFrom(scriptName: "darkmodeParam") else {
            return
        }
        DispatchQueue.main.async {
            self.darkModeOnButton.isHidden = darkMode.booleanValue
            self.darkModeOffButton.isHidden = !darkMode.booleanValue
        }
    }
    
    @IBAction func activateDarkMode(sender: Any) {
        
        let _ = AppleScriptHelper.launchScript(scriptName: "darkmodeSwitcher")
        
        detectDarkMode()
        
        self.statusMenu?.cancelTracking()
    }
    
    fileprivate func detectStartUpOption() {
        
        let isStartupOnLogin = LoginServiceKit.isExistLoginItems(at: Bundle.main.bundlePath)
        
        startUpCheckbox.state = isStartupOnLogin == true ? .on : .off
        startUpCheckbox.title = "enable_start_up_login".localized
    }
    
    @IBAction func removeAppFromLaunch(sender: Any) {
        
        let isStartupOnLogin = LoginServiceKit.isExistLoginItems(at: Bundle.main.bundlePath)
        
        if isStartupOnLogin == true {
            LoginServiceKit.removeLoginItems(at: Bundle.main.bundlePath)
        } else {
            LoginServiceKit.addLoginItems(at: Bundle.main.bundlePath)
        }
        
        detectStartUpOption()
    }
}
