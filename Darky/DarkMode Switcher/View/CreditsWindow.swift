//
//  CreditsWindow.swift
//  DarkMode Switcher
//
//  Created by Mohamed Arradi-Alaoui on 11/06/2018.
//  Copyright © 2018 Mohamed ARRADI. All rights reserved.
//

import Foundation
import Cocoa

class CreditsWindow: NSWindowController {

    @IBOutlet weak var descriptionMessageLabel: NSTextField!
    
    override var windowNibName: NSNib.Name? {
        return NSNib.Name(rawValue: "CreditsWindow")
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        self.window?.titlebarAppearsTransparent =  true
        
        self.window?.center()
        self.window?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
        
        let creditsText = String(format: "credit_description".localized, "https://www.flaticon.com/authors/epiccoders (www.flaticon.com)", "https://www.iconfinder.com/vectorsquare")
        
        descriptionMessageLabel.stringValue = creditsText
    }
}
