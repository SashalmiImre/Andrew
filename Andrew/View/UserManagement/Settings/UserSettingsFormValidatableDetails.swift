//
//  UserSettingsFormValidatableDetails.swift
//  Andrew
//
//  Created by Sashalmi Imre on 2020. 09. 20..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import Foundation

extension UserSettingsController {
    struct ValidationDetails: OptionSet {
        let rawValue: Int32
        
        static let name = ValidationDetails(rawValue: 1 << 0)
        
        static let all: ValidationDetails = [.name]
    }
}
