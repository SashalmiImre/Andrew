//
//  UserRegistrationController.swift
//  Andrew
//
//  Created by Sashalmi Imre on 2020. 09. 14..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import Foundation
import Cocoa
import FirebaseAuth

class UserRegistrationController: NSViewController {
    @IBOutlet weak var emailTextField: EmailTextField!
    @IBOutlet weak var passwordTextField: PasswordSecureTextField!
    @IBOutlet weak var rePasswordTextField: PasswordSecureTextField!
    
    @IBAction func cancelButtonClicked(_ sender: NSButton) {
        AppDelegate.mainContentController.setAppropriateViewController()
    }
    
    @IBAction func registrationButtonClicked(_ sender: NSButton) {
        let result = self.validateForm()
                
        switch result {
        case .success(let credentials):
            Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { (dataResult, error) in
              guard let error = error else { return }
                let errorCode = (error as NSError).code
                if let firebaseError = ServerAuthenticationErrors(rawValue: errorCode) {
                    self.showAlert(with: firebaseError)
                    return
                }
                self.showAlert(with: error)
            }
        case.failure(let error):
            self.showAlert(with: error)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        self.emailTextField.becomeFirstResponder()
    }
    
    private func validateForm() -> Result<UserCredentials, RegistrationFormError> {
        if !self.emailTextField.isValid(emptyIsValid: false) {
            return self.emailTextField.stringValue.isEmpty ?
                .failure(.emailNotSet) : .failure(.emailFormatNotValid)
        }
        if self.passwordTextField.stringValue.isEmpty {
            return .failure(.passwordNotSet)
        }
        if self.passwordTextField.strength < .moderate {
            return .failure(.passwordNotStrongEnough)
        }
        if self.passwordTextField.stringValue != self.rePasswordTextField.stringValue {
            return .failure(.passwordsDoNotMatch)
        }
        
        let credentials = (self.emailTextField.stringValue, self.passwordTextField.stringValue, "")
        return .success(credentials)
    }
    
    private func showAlert(with error: Error) {
        guard let window = self.view.window else { return }
        let alert = NSAlert(error: error)
        alert.beginSheetModal(for: window)
    }
}
