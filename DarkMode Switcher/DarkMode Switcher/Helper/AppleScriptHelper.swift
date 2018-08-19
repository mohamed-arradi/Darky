//
//  AppleScriptHelper.swift
//  DarkMode Switcher
//
//  Created by Mohamed Arradi on 6/9/18.
//  Copyright © 2018 Mohamed ARRADI. All rights reserved.
//

import Foundation

struct AppleScriptHelper {
    
    static func launchScript(scriptName: String?, bundle: Bundle = Bundle.main) -> Bool? {
        
        guard let scriptFilePath = bundle.path(forResource: scriptName, ofType: "scpt") else {
            return nil
        }
        
        let contentOfFile = try? String(contentsOfFile: scriptFilePath)
        
        guard let appleScript = contentOfFile else {
            return nil
        }
        
        var error: NSDictionary?
        if let scriptObject = NSAppleScript(source: appleScript) {
            let output: NSAppleEventDescriptor = scriptObject.executeAndReturnError(
                &error)
            if error == nil {
                return output.booleanValue
            }
            else {
                print(error!)
                return nil
            }
        }
        
        return nil
    }
    
    static func getValueFrom(scriptName: String?, bundle: Bundle = Bundle.main) -> NSAppleEventDescriptor? {
        
        guard let scriptFilePath = bundle.path(forResource: scriptName, ofType: "scpt") else {
            return nil
        }
        
        let contentOfFile = try? String(contentsOfFile: scriptFilePath)
        
        guard let appleScript = contentOfFile else {
            return nil
        }
        
        var error: NSDictionary?
        if let scriptObject = NSAppleScript(source: appleScript) {
            let output: NSAppleEventDescriptor = scriptObject.executeAndReturnError(
                &error)
            if error == nil {
                return output
            }
            else {
                return nil
            }
        }
        
        return nil
    }
}
