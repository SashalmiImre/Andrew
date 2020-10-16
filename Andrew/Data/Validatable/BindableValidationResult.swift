//
//  BindableValidationResult.swift
//  Andrew
//
//  Created by Sashalmi Imre on 2020. 08. 16..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import Foundation

@objc
class BindableResult: NSObject {
    @objc var type: String
    @objc var info: String
    
    init<ErrorType: ValidationError>(result: ValidationResult<ErrorType>) {
        self.type = result.type.rawValue
        self.info = result.error.localizedDescription
    }
}

protocol BindableConvertible {
    var bindableResult: BindableResult { get }
}

