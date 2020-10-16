//
//  UserRegistrationFormErrors.swift
//  Andrew
//
//  Created by Sashalmi Imre on 2020. 09. 16..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import Foundation

extension UserRegistrationController {
    enum RegistrationFormError: Error {
        case emailNotSet
        case emailFormatNotValid
        case passwordNotSet
        case passwordNotStrongEnough
        case passwordsDoNotMatch
    }
}

extension UserRegistrationController.RegistrationFormError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .emailNotSet:
            return "Nincs megadva emailcím!"
        case .emailFormatNotValid:
            return "Az emailcím formátuma nem megfelelő!"
        case .passwordNotSet:
            return "Nincs megadva jelszó!"
        case .passwordNotStrongEnough:
            return "A jelszó nem elég erős!"
        case .passwordsDoNotMatch:
            return "A jelszavak nem egyeznek!"
        }
    }
    
    public var recoverySuggestion: String? {
        switch self {
        case .emailNotSet:
            return "A regisztrációhoz szükséges megadnod egy érvényes emailcímet!"
        case .emailFormatNotValid:
            return "A beírt emailcím formátuma nem megfelelő! Kérlek ellenőrizd!"
        case .passwordNotSet:
            return "A regisztrációhoz szükséges megadnod egy megfelelően erős jelszót!"
        case .passwordNotStrongEnough:
            return "A megadott jelszó nem elég biztonságos. Kérlek adj meg egy erősebb jelszót, használj számokat, nagybetűket és speciális karaktereket."
        case .passwordsDoNotMatch:
            return "A két megadott jelszó nem egyezik."
        }
    }
}
