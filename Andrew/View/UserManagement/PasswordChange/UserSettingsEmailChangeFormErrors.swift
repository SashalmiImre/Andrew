//
//  UserSettingsEmailChangeFormErrors.swift
//  Andrew
//
//  Created by Sashalmi Imre on 2020. 10. 01..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import Foundation

extension UserSettingsEmailChangeController {
    enum FormErrors: Error {
        case emailNotSet
        case emailFormatNotValid
        case emailSameAsCurrent
        case noUserLoggedIn
    }
}

extension UserSettingsEmailChangeController.FormErrors: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .emailNotSet:
            return "Nincs megadva emailcím!"
        case .emailFormatNotValid:
            return "Az emailcím formátuma nem megfelelő!"
        case .emailSameAsCurrent:
            return "Az emailcím ugyanaz mint az eredeti!"
        case .noUserLoggedIn:
            return "Nincs felhasználó bejelentkezve!"
        }
    }
    
    public var recoverySuggestion: String? {
        switch self {
        case .emailNotSet:
            return "A művelet végrehajtásához szükséges a regisztrációkor megadott emailcímed!"
        case .emailFormatNotValid:
            return "A beírt emailcím formátuma nem megfelelő! Kérlek ellenőrizd!"
        case .emailSameAsCurrent:
            return "A beírt emailcím ugyanaz a cím, mint az eredeti! Kérlek ellenőrizd!"
        case .noUserLoggedIn:
            return "Jelenleg nincs egyetlen felhasználó sem bejelentkezve!"
        }
    }
}
