//
//  UserSettingsFormErrors.swift
//  Andrew
//
//  Created by Sashalmi Imre on 2020. 09. 20..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import Foundation

extension UserSettingsController {
    enum FormErrors: Error {
        case nameNotSet
    }
}

extension UserSettingsController.FormErrors: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .nameNotSet:
            return "Nincs megadva név!"
        }
    }
    
    public var recoverySuggestion: String? {
        switch self {
        case .nameNotSet:
            return "A név megadása kötelező."
        }
    }
}
