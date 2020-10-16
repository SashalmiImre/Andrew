//
//  ServerAuthenticationErrors.swift
//  Andrew
//
//  Created by Sashalmi Imre on 2020. 09. 16..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//
// Details at: https://firebase.google.com/docs/auth/ios/errors

import Foundation
import FirebaseAuth

enum ServerAuthenticationErrors: Int, LocalizedError  {
    
    static func safeCreate(with error: NSError) -> ServerAuthenticationErrors {
        return ServerAuthenticationErrors(error: error) ?? ServerAuthenticationErrors(rawValue: -1)!
    }
  
    init?(error: NSError) {
        let errorCode = error.code
        self.init(rawValue: errorCode)
    }

    case networkError           = 17020
    case userNotFound           = 17011
    case userTokenExpired       = 17021
    case tooManyRequests        = 17010
    case invalidAPIKey          = 17023
    case appNotAuthorized       = 17028
    case keychainError          = 17995
    case internalError          = 17999
        
    // Method specific error codes
    case invalidEmail           = 17008
    case operationNotAllowed    = 17006
    case userDisabled           = 17005
    case wrongPassword          = 17009
    case invalidCredential      = 17004
    case emailAlreadyInUse      = 17007
    case weakPassword           = 17026
        
    // FIRUser
    case invalidUserToken       = 17017
    case userMismatch           = 17024
    case requiresRecentLogin    = 17014
    case providerAlreadyLinked  = 17015
    case credentialAlreadyInUse = 17025
    case noSuchProvider         = 17016
    
    // Original
    case originalError          = -1
}

extension ServerAuthenticationErrors {
    
    public var errorDescription: String? {
        switch self {
            
        // Error codes common to all API methods
        case .networkError:
            return "Hálózati hiba!"
        case .userNotFound:
            return "A felhasználói fiók nem található!"
        case .userTokenExpired:
            return "A felhasználói token lejárt!"
        case .tooManyRequests:
            return "Túl sok kérés!"
        case .invalidAPIKey:
            return "Érvénytelen alkalmazás-azonosító!"
        case .appNotAuthorized:
            return "Az alkalmazás nincs engedélyezve!"
        case .keychainError:
            return "Kulcskarika hiba!"
        case .internalError:
            return "Belső hiba!"
            
        // Method specific error codes
        case .invalidEmail:
            return "Érvénytelen e-mail cím!"
        case .operationNotAllowed:
            return "Nem engedélyezett művelet!"
        case .userDisabled:
            return "A felhasználói fiók fel van függesztve!"
        case .wrongPassword:
            return "Nem megfelelő jelszó!"
        case .invalidCredential:
            return "Helytelen azonosító!"
        case .emailAlreadyInUse:
            return "A megadott e-mail cím már használatban van!"
        case .weakPassword:
            return "A megadott jelszó nem megfelelő erősségű!"
            
        // FIRUser
        case .invalidUserToken:
            return "Érvénytelen token!"
        case .userMismatch:
            return "Nem megegyező felhasználói fiók!"
        case .requiresRecentLogin:
            return "Újrahitelesítés szükséges!"
        case .providerAlreadyLinked:
            return "Hozzárendelési hiba!"
        case .credentialAlreadyInUse:
            return "Hozzárendelési hiba!"
        case .noSuchProvider:
            return "Hozzárendelési hiba!"
            
        // Original
        case .originalError:
            return "Azonosítattlan hiba!"
        }
    }
    
    
    public var recoverySuggestion: String? {
        switch self {
            
        // Error codes common to all API methods
        case .networkError:
            return "A hitelesítés közben hálózati hiba lépett fel."
        case .userNotFound:
            return "A megadott felhasználói fiók nem található. Elképzelhető, hogy már törlésre került."
        case .userTokenExpired:
            return "A megadott felhasználói token ervényességi ideje lejárt. Jelentkezzen be az eszközön újra!"
        case .tooManyRequests:
            return "Rendellenes mennyiségű kérés érkezett az eszközről. Később próbálja meg újra a bejelentkezést!"
        case .invalidAPIKey:
            return "Az alkalmazás egyedi azonosítója nem elfogadható."
        case .appNotAuthorized:
            return "Az alkalmazásnak nincs engedélye, hogy használja a megadott alkalmazás-azonosítót."
        case .keychainError:
            return "Hiba történt a kulcskarika elérésekor."
        case .internalError:
            return "Belső hiba lépett fel."
            
        // Method specific error codes
        case .invalidEmail:
            return "A megadott e-mail, nem megfelelő formátumú."
        case .operationNotAllowed:
            return "A használt bejelentkezési forma nem engedélyezett."
        case .userDisabled:
            return "A felhasználói fiókot valamilyen okból felfüggesztették, érdeklődjön a rendszergazdánál."
        case .wrongPassword:
            return "A felhasználói fiókhoz a megadott jelszó nem megfelelő."
        case .invalidCredential:
            return "A megadott érvényesítő adat helytelen. Előfordulhat, hogy már lejárt, vagy rosszul van megadva."
        case .emailAlreadyInUse:
            return "A megadott e-mail cím már használatban van."
        case .weakPassword:
            return "A megadott jelszó nem megfelelő erősségű."
            
        // FIRUser
        case .invalidUserToken:
            return "A munkamenet-információkat tartalmazó frissítési tokenje érvénytelen. Kérem jelentkezzen be ezen az eszközön újra."
        case .userMismatch:
            return "Nem a jelenlegi felhasználóval történt újrahitelesétési kisérlet."
        case .requiresRecentLogin:
            return "A művelet végrehajtásához még nem telt el elég idő a bejelentkazés óta. Újrahitelesítés szükséges."
        case .providerAlreadyLinked:
            return "A szolgáltató már a felhasználói fiókhoz van rendelve."
        case .credentialAlreadyInUse:
            return "A hitelesítő adatok már egy másik felhasználói fiókhoz vannak rendelve."
        case .noSuchProvider:
            return "Ez a szolgáltató nem kapcsolódik a megadott felhasználói fiókhoz."
            
        // Original
        case .originalError:
            return "Azonosítattlan hiba!"
        }
    }
}
