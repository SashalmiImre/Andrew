//
//  HeaderLabel.swift
//  Andrew
//
//  Created by Sashalmi Imre on 2020. 09. 17..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import Foundation
import Cocoa

class HeaderTextField: NSTextField {
    
    override func viewWillDraw() {
        self.addCharacterSpacing()
    }
    
    func addCharacterSpacing(kernValue: Double = 1.15) {
        let labelText = self.stringValue
        let range = NSMakeRange(0, labelText.count - 1)
        let attributedString = NSMutableAttributedString(string: labelText)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: kernValue, range: range)
        self.attributedStringValue = attributedString
    }
}
