//
//  UserSettingsEmailChangeValidationDetails.swift
//  Andrew
//
//  Created by Sashalmi Imre on 2020. 10. 01..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import Foundation

extension UserSettingsEmailChangeController {
    struct ValidationDetails: OptionSet {
        let rawValue: Int32
        
        static let emailTextField    = ValidationDetails(rawValue: 1 << 0)
        
        static let all: ValidationDetails = [.emailTextField]
    }
}
