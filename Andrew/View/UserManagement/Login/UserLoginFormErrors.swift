//
//  UserLoginFormErrors.swift
//  Andrew
//
//  Created by Sashalmi Imre on 2020. 09. 16..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import Foundation

extension UserLoginController {
    enum FormErrors: Error {
        case emailNotSet
        case emailFormatNotValid
        case passwordNotSet
    }
}

extension UserLoginController.FormErrors: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .emailNotSet:
            return "Nincs megadva emailcím!"
        case .emailFormatNotValid:
            return "Az emailcím formátuma nem megfelelő!"
        case .passwordNotSet:
            return "Nincs megadva jelszó!"
        }
    }
    
    public var recoverySuggestion: String? {
        switch self {
        case .emailNotSet:
            return "A művelet végrehajtásához szükséges a regisztrációkor megadott emailcímed!"
        case .emailFormatNotValid:
            return "A beírt emailcím formátuma nem megfelelő! Kérlek ellenőrizd!"
        case .passwordNotSet:
            return "A bejelentkezéshez szükséges a regisztrációkor megadott emailcímhez tartozó jelszó!"
        }
    }
}
