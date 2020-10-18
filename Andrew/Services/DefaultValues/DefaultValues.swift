//
//  DefaultValues.swift
//  Andrew
//
//  Created by Sashalmi Imre on 2020. 08. 29..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import Foundation
import FirebaseAuth
import Cocoa

class DefaultValues {
    
    private var authenticationHandler: AuthStateDidChangeListenerHandle!
    var loggedUser: User?
    private var persistentDomain: [String : Any]
    
    
    // MARK: - Initialization/deinitialization
    
    init() {
        if let loadedDefaults = UserDefaults.standard.persistentDomain(forName: "Andrew") {
            persistentDomain = loadedDefaults
        } else {
            guard let path = Bundle.main.path(forResource: "Defaults", ofType: "plist") else {
                fatalError("No Defaults.plist file!")
            }
            persistentDomain = NSDictionary(contentsOfFile: path)! as! [String : Any]
        }
        Auth.auth().languageCode = "hu"
        self.authenticationHandler = Auth.auth().addStateDidChangeListener { (auth, user) in
            self.loggedUser = user
            AppDelegate.mainContentController.setAppropriateViewController()
        }
    }
    
    deinit {
        Auth.auth().removeStateDidChangeListener(self.authenticationHandler)
    }
    
    // MARK: - Managing values
    
    func value<T>(forKey key: DefaultValues.Keys, type: T.Type) -> T? {
        guard let value = self[key] as? T else { return nil }
        return value
    }
    
    func reset() {
        UserDefaults.standard.removePersistentDomain(forName: "Andrew")
    }
    
    subscript(key: DefaultValues.Keys) -> Any? {
        get {
            switch key {
            case .currentUser:
                return loggedUser
            default:
                return persistentDomain[key.rawValue]
            }
        }
        set(value) {
            persistentDomain[key.rawValue] = value
            UserDefaults.standard.setPersistentDomain(persistentDomain, forName: "Andrew")
        }
    }
}

extension DefaultValues {
    enum Keys: String {
        case databasePath
        case currentUser
    }
}
