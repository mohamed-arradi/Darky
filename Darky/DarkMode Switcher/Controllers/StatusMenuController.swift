//
//  StatusMenuController.swift
//  WeatherBar
//
//  Created by Brad Greenlee on 10/11/15.
//  Copyright © 2015 Etsy. All rights reserved.
//

import Cocoa
import Magnet

enum VersionError: Error {
    case invalidResponse, invalidBundleInfo
}

class StatusMenuController: NSObject, PreferencesWindowDelegate, NSAlertDelegate {
    
    @IBOutlet weak var statusMenu: NSMenu!
    @IBOutlet weak var darkModeStatusView: StatusView!
    
    let mac_app_store_distribution = true

    var timer: Timer?
    
    var statusMenuItem: NSMenuItem!
    
    lazy var preferencesWindow: PreferencesWindow = {
        
        let preference = PreferencesWindow()
        preference.delegate = self
        
        return preference
    }()
    
    lazy var aboutView: AboutWindow = {
        return AboutWindow()
    }()
    
    lazy var creditView: CreditsWindow = {
        return CreditsWindow()
    }()
    
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    
    override func awakeFromNib() {
        
        statusItem.menu = statusMenu
        let icon = NSImage(named: NSImage.Name(rawValue: "StatusIcon"))
        icon?.isTemplate = true // best for dark mode
        statusItem.image = icon
        statusItem.menu = statusMenu
        
        statusMenu.item(at: 2)?.title = "settings".localized
        statusMenu.item(at: 4)?.title = "about".localized
        statusMenu.item(at: 6)?.title = "credits".localized
        statusMenu.item(at: 8)?.title = "quit_app".localized
        
        statusMenuItem = statusMenu.item(at: 0)
        
        darkModeStatusView.statusMenu = statusMenu
        
        statusMenuItem.view = darkModeStatusView
        
        updateSettings()
        
        if let keyCombo = KeyCombo(keyCode: 11, carbonModifiers: 4352) {
            let hotKey = HotKey(identifier: "CommandControlB", keyCombo: keyCombo, target: self, action: #selector(changeDarkMode))
            hotKey.register()
        }
    }
    
    @objc func updateSettings() {
        darkModeStatusView.detectDarkMode()
    }
    
    @objc func changeDarkMode() {
        darkModeStatusView.activateDarkMode(sender: self)
    }
    
    // MARK: - IBAction
    
    @IBAction func preferencesClicked(_ sender: NSMenuItem) {
        preferencesWindow.showWindow(nil)
        DarkMode.toggle()
    }
    
    @IBAction func quitClicked(_ sender: NSMenuItem) {
        NSApplication.shared.terminate(self)
    }
    
    @IBAction func aboutAppClicked(_ sender: NSMenuItem) {
        aboutView.showWindow(nil)
    }
    
    @IBAction func creditAppClicked(_ sender: NSMenuItem) {
        creditView.showWindow(nil)
    }
    
    func preferencesDidUpdate() {
        updateSettings()
    }
}
