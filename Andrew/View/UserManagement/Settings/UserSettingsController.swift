//
//  UserSettingsController.swift
//  Andrew
//
//  Created by Sashalmi Imre on 2020. 09. 17..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import Foundation
import Cocoa
import FirebaseAuth

class UserSettingsController: NSViewController, FormValidatable, InProgressVisualizable {
    
    @objc var inProgress: Bool = false {
        didSet { self.setAppearance() }
    }
    
    @IBOutlet weak var nameTextField: NSTextField!
    @IBOutlet weak var headerInformativeText: NSTextField!
    @IBOutlet weak var multiButton: NSButton!

    
    // MARK: - Button actions
    
    @IBAction func emailChangeButtonClicked(_ sender: NSButton) {
        guard let window = self.view.window else { return }
        self.inProgress = true
        let storyboard = NSStoryboard(name: "UserSettingsEmailChange", bundle: nil)
        let viewController = storyboard.instantiateController(withIdentifier: "UserSettingsEmailChangeController") as! UserSettingsEmailChangeController

        let panel = NSPanel(contentViewController: viewController)
        panel.styleMask.remove(.resizable)
        window.beginSheet(panel) { (response) in
            self.inProgress = false
            switch response {
            case .OK:
                try? Auth.auth().signOut()
            default:
                break
            }
        }
    }
    
    @IBAction func passwordChangeButtonClicked(_ sender: NSButton) {
        guard let window = self.view.window,
              let email = AppDelegate.defaults.loggedUser?.email else { return }
        self.inProgress = true
        let alert = NSAlert()
        alert.alertStyle = .warning
        alert.messageText = "Levél elküldve"
        alert.informativeText = "A(z) \(email) e-mail címre küldött levélben megtalálható a jelszócseréhez szükséges összes információ."
        alert.beginSheetModal(for: window)
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            self.inProgress = false
            guard let error = error else { return }
            
            self.showAlert(with: error)
        }
    }
    
    @IBAction func multiButtonClicked(_ sender: NSButton) {
        switch sender.title {
        case "Fiók törlése":
            self.deleteUser()
        default:
            let result = self.validateForm([.name])
            switch result {
            case .success(_):
                self.changeUserData()
            default:
                break
            }
        }
    }
    
    @IBAction func logOutButtonClicked(_ sender: NSButton) {
        try? Auth.auth().signOut()
    }
    
    
    // MARK: - Modifying user account
    
    private func changeUserData() {
        guard let loggedUser = AppDelegate.defaults.loggedUser else { return }
        guard loggedUser.displayName != self.nameTextField.stringValue else {
            AppDelegate.mainContentController.setAppropriateViewController()
            return
        }
        self.inProgress = true
        let changeRequest = loggedUser.createProfileChangeRequest()
        changeRequest.displayName = self.nameTextField.stringValue
        changeRequest.commitChanges { (error) in
            self.inProgress = false
            if let  error = error as NSError? {
                let error = ServerAuthenticationErrors.safeCreate(with: error)
                self.showAlert(with: error)
                return
            }
            AppDelegate.mainContentController.setAppropriateViewController()
        }
    }
    
    private func deleteUser() {
        guard let loggedUser = AppDelegate.defaults.loggedUser,
              let window = self.view.window else { return }
        self.inProgress = true
        let alert = NSAlert()
        alert.alertStyle = .critical
        alert.messageText = "Fiók törlése"
        alert.informativeText = "Arra készül, hogy törölje a(z) \(loggedUser.email!) e-mail címhez tartozó felhasználói fiókot. A törlés gomb megnyomásával megteheti, de vegye figyelembe, hogy a művelet nem visszavonható!"
        alert.addButton(withTitle: "Mégsem")
        alert.addButton(withTitle: "Fiók törlése")
        alert.beginSheetModal(for: window) { (response) in
            if response == .alertSecondButtonReturn {
                loggedUser.delete { (error) in
                    if let  error = error as NSError? {
                        let error = ServerAuthenticationErrors.safeCreate(with: error)
                        self.showAlert(with: error)
                        return
                    }
                    AppDelegate.mainContentController.setAppropriateViewController()
                }
            }
            self.inProgress = false
        }
    }
    
    // MARK: - View events
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let user = AppDelegate.defaults.loggedUser else { return }
        self.headerInformativeText.stringValue = "A(z) \(user.email!) e-mail címhez tartozó\rfelhasználói fiók tulajdonosának neve:"
        self.nameTextField.stringValue = user.displayName ?? NSFullUserName()

        NSEvent.addLocalMonitorForEvents(matching: .flagsChanged) {
            self.modifierFlagsChanged(with: $0)
            return $0
        }
    }
    
    
    // MARK: - Modifier keys event handler
    
    private func modifierFlagsChanged(with event: NSEvent) {
        switch event.modifierFlags.intersection(.deviceIndependentFlagsMask) {
        case [.option, .control]:
            self.multiButton.title = "Fiók törlése"
            self.multiButton.keyEquivalent = ""
        default:
            self.multiButton.title = "Beállítások mentése"
            self.multiButton.keyEquivalent = "\r"
        }
    }
    
    
    // MARK: - Validation
    func validateForm(_ details: [ValidationDetails]) -> Result<UserCredentials, FormErrors> {
        if details.contains(.name) {
            if self.nameTextField.stringValue.isEmpty { return .failure(.nameNotSet) }
        }
        let credentials = (AppDelegate.defaults.loggedUser?.email ?? "", "", self.nameTextField.stringValue)
        return .success(credentials)
    }
}
