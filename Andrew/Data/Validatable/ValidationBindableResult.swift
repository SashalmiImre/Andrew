//
//  BindableValidationResult.swift
//  Andrew
//
//  Created by Sashalmi Imre on 2020. 08. 16..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import Foundation

@objc
class ValidationBindableResult: NSObject {
    @objc var type: String
    @objc var info: String
    
    init<ValidationErrorType: ValidationError>(result: ValidationResult<ValidationErrorType>) {
        switch result {
        case .success:
            self.type = "success"
            self.info = ""
        case .warning(let error):
            self.type = "success"
            self.info = error.localizedDescription
        case .error(let error):
            self.type = "success"
            self.info = error.localizedDescription
        case .info(let error):
            self.type = "success"
            self.info = error.localizedDescription
        }
    }
}

protocol BindableConvertible {
    var bindableResult: ValidationBindableResult { get }
}
