//
//  UserLoginController.swift
//  Andrew
//
//  Created by Sashalmi Imre on 2020. 09. 13..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import Foundation
import Cocoa
import FirebaseAuth

class UserLoginController: NSViewController, FormValidatable, InProgressVisualizable {
    
    @IBOutlet weak var emailTextField: EmailTextField!
    @IBOutlet weak var passwordTextField: NSSecureTextField!
    @IBOutlet weak var passwordResetButton: NSButton!
    
    
    // MARK: - InProgressVisualizable conformance
    
    @objc var inProgress: Bool = false {
        didSet { self.setAppearance() }
    }
    var informationViewName: String? = nil

    
    // MARK: - View events
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.passwordTextField.delegate = self
    }

    override func viewDidAppear() {
        super.viewDidAppear()
        self.emailTextField.becomeFirstResponder()
    }
    
    
    // MARK: - Button actions
    
    @IBAction func loginButtonClicked(_ sender: NSButton) {
        let result = self.validateForm([.emailTextField, .passwordTextField])
                
        switch result {
        case .success(let credentials):
            self.inProgress = true
            Auth.auth().signIn(withEmail: credentials.email, password: credentials.password) { (dataResult, error) in
                self.inProgress = false
                guard let error = error as NSError? else { return }
                let firebaseError = ServerAuthenticationErrors.safeCreate(with: error)
                self.showAlert(with: firebaseError)
            }
        case.failure(let error):
            self.showAlert(with: error)
        }
    }
    
    @IBAction func passwordResetButtonClicked(_ sender: NSButton) {
        guard let window = self.view.window else { return }
        let result = self.validateForm([.emailTextField])
        
        switch result {
        case .success(let credentials):
            self.inProgress = true
            let alert = NSAlert()
            alert.alertStyle = .warning
            alert.messageText = "Levél elküldve"
            alert.informativeText = "A(z) \(credentials.email) e-mail címre küldött levélben megtalálható a jelszócseréhez szükséges összes információ."
            alert.beginSheetModal(for: window)
            Auth.auth().sendPasswordReset(withEmail: credentials.email) { error in
                self.inProgress = false
                guard let error = error as NSError? else { return }
                let firebaseError = ServerAuthenticationErrors.safeCreate(with: error)
                self.showAlert(with: firebaseError)
            }
        case .failure(let error):
            self.showAlert(with: error)
        }
    }
    
    @IBAction func registrationButtonClicked(_ sender: NSButton) {
//        let storyboard = NSStoryboard(name: "UserRegistration", bundle: nil)
//        let viewController = storyboard.instantiateInitialController() as! NSViewController
//        let mainViewController = self.parent as! MainViewController
//        mainViewController.changeViewController(to: viewController)
        AppDelegate.mainContentController.changeViewController(to: "UserRegistration")
    }
    
    
    // MARK: - Validation
    
    func validateForm(_ details: [ValidationDetails]) -> Result<UserCredentials, FormErrors> {
        if details.contains(.emailTextField) {
            if !self.emailTextField.isValid(emptyIsValid: false) {
                return self.emailTextField.stringValue.isEmpty ?
                    .failure(.emailNotSet) : .failure(.emailFormatNotValid)
            }
        }
        if details.contains(.passwordTextField) {
            if self.passwordTextField.stringValue.isEmpty {
                return .failure(.passwordNotSet)
            }
        }
        let credentials = (self.emailTextField.stringValue, self.passwordTextField.stringValue, "")
        return .success(credentials)
    }
}

extension UserLoginController: NSTextFieldDelegate {
    func controlTextDidChange(_ obj: Notification) {
        self.passwordResetButton.isHidden = self.passwordTextField.stringValue.count > 25
    }
}
