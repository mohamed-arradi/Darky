//
//  SettingsView.swift
//  DarkMode Switcher
//
//  Created by Mohamed Arradi on 6/11/18.
//  Copyright © 2018 Mohamed ARRADI. All rights reserved.
//

import Foundation
import OGSwitch

class StatusView: NSView {
    
    @IBOutlet weak var switchControl: OGSwitch!
    @IBOutlet weak var statusLabel: NSTextField!
    
    weak var statusMenu: NSMenu?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        detectDarkMode()
    }
    
    @objc func detectDarkMode() {
        
        guard let darkMode =  AppleScriptHelper.getValueFrom(scriptName: "darkmodeParam") else {
            self.switchControl.isEnabled = false
            self.switchControl.isHidden = true
            self.statusLabel.isHidden = true
            return
        }
            DispatchQueue.main.async {
                
                self.switchControl.isEnabled = true
                self.switchControl.isHidden = false
                self.statusLabel.isHidden = false
                
                let bool = darkMode.booleanValue
                
                self.switchControl.isOn = bool
                self.statusLabel.stringValue = bool == true ? "activate_dark_mode".localized.appending(" (⌘+Ctrl+B)") : "desactivate_dark_mode".localized.appending(" (⌘+Ctrl+B)")
        }
    }
    
    @IBAction func activateDarkMode(sender: Any) {
        
        let _ = AppleScriptHelper.launchScript(scriptName: "darkmodeSwitcher")
        
         self.detectDarkMode()
        
        self.statusMenu?.cancelTracking()
    }
}
