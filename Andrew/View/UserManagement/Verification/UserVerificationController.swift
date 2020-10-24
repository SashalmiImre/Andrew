//
//  UserVerificationController.swift
//  Andrew
//
//  Created by Sashalmi Imre on 2020. 10. 01..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import Foundation
import Cocoa
import FirebaseAuth

class UserVerificationController: NSViewController, InProgressVisualizable {

    var timer: Timer!
    
    @IBOutlet weak var infoText: NSTextField!
    
    
    // MARK: - InProgressVisualizable conformance
    
    var inProgress: Bool = false {
        didSet { self.setAppearance() }
    }
    var informationViewName: String? = nil

    
    // MARK: - View cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let loggedUser = AppDelegate.defaults.loggedUser,
              let emailAddress = loggedUser.email else { return }
        self.infoText.stringValue = "A \(emailAddress) címre elküldtünk egy levelet, amelyben egy linket talál, amire rákkantintva elvégezheti a fiókja érvénesítését!"
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(checkUserVerifiedState), userInfo: nil, repeats: true)
        print("initsend")
        self.sendVerificationEmail()
    }
    
    override func viewWillDisappear() {
        self.timer.invalidate()
    }
    
    @objc func checkUserVerifiedState() {
        guard let loggedUser = AppDelegate.defaults.loggedUser else { return }
        loggedUser.reload { (error) in
            guard error == nil,
                  loggedUser.isEmailVerified else { return }
            AppDelegate.mainContentController.setAppropriateViewController()
        }
    }
    
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
    
    @IBAction func resendVerificationEmailButtonClicked(_ sender: NSButton) {
        self.sendVerificationEmail()
    }
    
    @IBAction func logoutButtonClicked(_ sender: NSButton) {
        try? Auth.auth().signOut()
    }
    
    // MARK: - Private methods
    
    private func sendVerificationEmail() {
        guard let loggedUser = AppDelegate.defaults.loggedUser else { return }
        loggedUser.sendEmailVerification { (error) in
            if let  error = error as NSError? {
                print(error.code)
                let error = ServerAuthenticationErrors.safeCreate(with: error)
                self.showAlert(with: error)
                return
            }
            AppDelegate.mainContentController.setAppropriateViewController()
        }
    }
    
    private func showAlert(with error: Error) {
        guard let window = self.view.window else { return }
        let alert = NSAlert(error: error)
        alert.beginSheetModal(for: window) { _ in

        }
    }
    
}
