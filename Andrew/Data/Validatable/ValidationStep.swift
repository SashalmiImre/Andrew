//
//  ValidatorStep.swift
//  Andrew
//
//  Created by Sashalmi Imre on 2020. 08. 21..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import Foundation

typealias ValidationStep<ValidatableObject: Validatable> = (ValidatableObject) -> ValidationResult<ValidatableObject.ValidationErrorType>
