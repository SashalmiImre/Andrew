//
//  EmailTextField.swift
//  Andrew
//
//  Created by Sashalmi Imre on 2020. 09. 15..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import Foundation
import Cocoa

class EmailTextField: NSTextField {
    override func textDidChange(_ notification: Notification) {
        super.textDidChange(notification)
        let errorColor = NSColor(deviceRed: 1.0, green: 0.0, blue: 0.0, alpha: 0.15)
        self.backgroundColor = self.isValid() ? .textBackgroundColor : errorColor
    }

    func isValid(emptyIsValid: Bool = true) -> Bool {
        if self.stringValue.isEmpty && emptyIsValid { return true }

        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self.stringValue)
    }
}
