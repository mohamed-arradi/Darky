//
//  String+Localized.swift
//  DarkMode Switcher
//
//  Created by Mohamed Arradi on 6/9/18.
//  Copyright © 2018 Mohamed ARRADI. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
