//
//  PasswordSecureTextField.swift
//  Andrew
//
//  Created by Sashalmi Imre on 2020. 09. 16..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import Foundation
import Cocoa

class PasswordSecureTextField: NSSecureTextField {
    var strength: PasswordStrength {
        PasswordStrength.checkStrength(password: self.stringValue)
    }
    
    override func textDidChange(_ notification: Notification) {
        super.textDidChange(notification)
        switch self.strength {
        case .none:
            self.backgroundColor = .textBackgroundColor
        case .weak:
            self.backgroundColor = NSColor(deviceRed: 1.0, green: 0.0, blue: 0.0, alpha: 0.15)
        case .moderate:
            self.backgroundColor = NSColor(deviceRed: 1.0, green: 0.65, blue: 0.0, alpha: 0.15)
        case .strong:
            self.backgroundColor = NSColor(deviceRed: 0.0, green: 1.0, blue: 0.0, alpha: 0.15)
        }
    }
    
    // Thanks to https://gist.github.com/chamrc/4b74d0f6caa844116150
    enum PasswordStrength: Int, Comparable {
        case none
        case weak
        case moderate
        case strong

        static func checkStrength(password: String) -> PasswordStrength {
            var strength: Int = 0
            
            switch password.count {
            case 0:
                return .none
            case 1...4:
                strength += 1
            case 5...8:
                strength += 2
            default:
                strength += 3
            }
            
            // Upper case, Lower case, Number & Symbols
            let patterns = ["^(?=.*[A-Z]).*$", "^(?=.*[a-z]).*$", "^(?=.*[0-9]).*$", "^(?=.*[!@#%&-_=:;\"'<>,`~\\*\\?\\+\\[\\]\\(\\)\\{\\}\\^\\$\\|\\\\\\.\\/]).*$"]
            
            for pattern in patterns {
                if (password.range(of: pattern, options: .regularExpression) != nil) {
                    strength += 1
                }
            }
            
            switch strength {
            case 0:
                return .none
            case 1...4:
                return .weak
            case 5...6:
                return .moderate
            default:
                return .strong
            }
        }
        
        static func < (lhs: PasswordSecureTextField.PasswordStrength, rhs: PasswordSecureTextField.PasswordStrength) -> Bool {
            return lhs.rawValue < rhs.rawValue
        }
    }
}
