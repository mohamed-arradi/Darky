//
//  StatusMenuController.swift
//  WeatherBar
//
//  Created by Brad Greenlee on 10/11/15.
//  Copyright © 2015 Etsy. All rights reserved.
//

import Cocoa
import HotKey

class StatusMenuController: NSObject, NSAlertDelegate {
    
    @IBOutlet weak var statusMenu: NSMenu!
    @IBOutlet weak var darkModeStatusView: StatusView!
    
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    var statusMenuItem: NSMenuItem!
    
    fileprivate var hotKey: HotKey!
    
    lazy var aboutView: AboutWindow = {
        return AboutWindow()
    }()
    
    override func awakeFromNib() {
        
        statusItem.menu = statusMenu
        let icon = NSImage(named: "StatusIcon")
        icon?.isTemplate = true // best for dark mode
        statusItem.image = icon
        statusItem.menu = statusMenu

        statusMenu.item(at: 2)?.title = "about".localized
        statusMenu.item(at: 4)?.title = "quit_app".localized
        
        statusMenuItem = statusMenu.item(at: 0)
        darkModeStatusView.statusMenu = statusMenu
        statusMenuItem.view = darkModeStatusView
        
        darkModeStatusView.detectDarkMode()

        hotKey = HotKey(key: .d, modifiers: [.command])
        
        hotKey.keyDownHandler = {
            self.changeDarkMode()
        }
    }
    
    @objc func changeDarkMode() {
        darkModeStatusView.activateDarkMode(sender: self)
    }
    
    // MARK: - IBAction
    
    @IBAction func quitClicked(_ sender: NSMenuItem) {
        NSApplication.shared.terminate(self)
    }
    
    @IBAction func aboutAppClicked(_ sender: NSMenuItem) {
        aboutView.showWindow(nil)
    }
}
