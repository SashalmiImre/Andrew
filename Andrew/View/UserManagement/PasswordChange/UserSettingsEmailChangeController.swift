//
//  UserSettingsEmailChangeController.swift
//  Andrew
//
//  Created by Sashalmi Imre on 2020. 09. 29..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import Foundation
import Cocoa

class UserSettingsEmailChangeController: NSViewController, FormValidatable {
        
    @IBOutlet weak var emailTextField: EmailTextField!
    
    @IBAction func cancelButtonClicked(_ sender: NSButton) {
        guard let sheetWindow = self.view.window,
              let parentWindow = sheetWindow.sheetParent else { return }
        parentWindow.endSheet(sheetWindow, returnCode: .cancel)
    }
    
    @IBAction func emailChangeButtonClicked(_ sender: NSButton) {
        guard let user = AppDelegate.defaults.loggedUser,
              let sheetWindow = self.view.window,
              let parentWindow = sheetWindow.sheetParent else { return }
        let result = self.validateForm([.emailTextField])
        switch result {
        case .failure(let error):
            self.showAlert(with: error)
            return
        default:
            break
        }
        
        user.updateEmail(to: self.emailTextField.stringValue) { (error) in
            guard let error = error as NSError? else {
                parentWindow.endSheet(sheetWindow, returnCode: .OK)
                return
            }
            let firebaseError = ServerAuthenticationErrors.safeCreate(with: error)
            let alert = NSAlert(error: firebaseError)
            alert.beginSheetModal(for: sheetWindow) { (response) in
                parentWindow.endSheet(sheetWindow, returnCode: .abort)
            }
        }
    }
    
    
    // MARK: - Validation
    func validateForm(_ details: [ValidationDetails]) -> Result<UserCredentials, FormErrors> {
        guard let loggedUser = AppDelegate.defaults.loggedUser else { return .failure(.noUserLoggedIn) }
        if details.contains(.emailTextField) {
            if self.emailTextField.stringValue.isEmpty { return .failure(.emailNotSet) }
            if self.emailTextField.stringValue == loggedUser.email { return .failure(.emailSameAsCurrent) }
            if !self.emailTextField.isValid() { return .failure(.emailFormatNotValid) }
        }
        let credentials = (self.emailTextField.stringValue, "", "")
        return .success(credentials)
    }
}
