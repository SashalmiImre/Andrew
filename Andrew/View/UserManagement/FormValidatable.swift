//
//  UserFormValidatable.swift
//  Andrew
//
//  Created by Sashalmi Imre on 2020. 09. 19..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import Foundation
import Cocoa
import os.log

protocol FormValidatable where Self: NSViewController {
    associatedtype ValidationErrors: Error
    associatedtype ValidationDetails: OptionSet
        
    func validateForm(_ details: [ValidationDetails]) -> Result<UserCredentials, ValidationErrors>
}

extension FormValidatable {
    func showAlert(with error: Error) {
        guard let window = self.view.window else { return }
        let alert = NSAlert(error: error)
        alert.beginSheetModal(for: window) { _ in

        }
    }
}
