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
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.addCharacterSpacing(kernValue: 3.0)
    }
    
    func addCharacterSpacing(kernValue: Double = 1.0) {
        let labelText = self.stringValue
        let range = NSMakeRange(0, labelText.count - 1)
        let attributedString = NSMutableAttributedString(string: labelText)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: kernValue, range: range)
        self.attributedStringValue = attributedString
    }
}
