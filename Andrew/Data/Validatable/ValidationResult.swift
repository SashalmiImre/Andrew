//
//  ValidationResult.swift
//  Andrew
//
//  Created by Sashalmi Imre on 2020. 08. 21..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import Foundation

// MARK: - Result

enum ValidationResult<Error: ValidationError>: BindableConvertible {
    case success
    case warning(Error)
    case error(Error)
    case info(Error)
    
    var bindableResult: ValidationBindableResult { ValidationBindableResult(result: self) }
}

extension ValidationResult: Equatable {
    static func == (lhs: ValidationResult, rhs: ValidationResult) -> Bool {
        switch (lhs, rhs) {
        case (.success, .success):
            return true
        case (.warning(let lhsError), .warning(let rhsError)):
            return lhsError == rhsError
        case (.error(let lhsError), .error(let rhsError)):
            return lhsError == rhsError
        case (.info(let lhsError), .info(let rhsError)):
            return lhsError == rhsError
        default:
            return false
        }
    }
}


// MARK: - Results

typealias ValidationResults<Error: ValidationError> = Array<ValidationResult<Error>>

extension ValidationResults where Element: BindableConvertible {
    var bindableResults: Array<ValidationBindableResult> {
        return self.map { $0.bindableResult }
    }
}
