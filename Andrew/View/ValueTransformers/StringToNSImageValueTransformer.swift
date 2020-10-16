//
//  StringToNSImageValueTransformer.swift
//  Andrew
//
//  Created by Sashalmi Imre on 2020. 08. 17..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import Foundation

import Foundation
import Cocoa

class StringToNSImage: ValueTransformer {
    override class func transformedValueClass() -> AnyClass {
        return NSImage.self
    }
    
    override class func allowsReverseTransformation() -> Bool {
        return false
    }
    
    override func transformedValue(_ value: Any?) -> Any? {
        guard let imageName = value as? String else { return nil }
        return NSImage(named: NSImage.Name(imageName))
    }
}

extension NSValueTransformerName {
    static let stringToNSImage = NSValueTransformerName(rawValue: "StringToNSImage")
}
