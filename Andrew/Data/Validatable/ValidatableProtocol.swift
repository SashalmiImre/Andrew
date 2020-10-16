//
//  ValidatableProtocol.swift
//  Andrew
//
//  Created by Sashalmi Imre on 2020. 08. 23..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import Foundation

protocol Validatable {
    associatedtype ValidationErrorType: ValidationError
    func validationSteps() -> [ValidationStep<Self>]
}

extension Validatable {
    func validate() -> ValidationResults<ValidationErrorType>? {
        var results = Array<ValidationResult<ValidationErrorType>>()
        for validationStep in self.validationSteps() {
            let result = validationStep(self)
            guard result != .success else { continue }
            results.append(result)
        }
        return results.isEmpty ? nil : results
    }
}
