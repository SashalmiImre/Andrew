//
//  UserLoginFormValidationDetails.swift
//  Andrew
//
//  Created by Sashalmi Imre on 2020. 09. 19..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import Foundation

extension UserLoginController {
    struct ValidationDetails: OptionSet {
        let rawValue: Int32
        
        static let emailTextField    = ValidationDetails(rawValue: 1 << 0)
        static let passwordTextField = ValidationDetails(rawValue: 1 << 1)
        
        static let all: ValidationDetails = [.emailTextField, .passwordTextField]
    }
}
