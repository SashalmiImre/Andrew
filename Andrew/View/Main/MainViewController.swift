//
//  MainViewController.swift
//  Andrew
//
//  Created by Sashalmi Imre on 2020. 09. 14..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import Foundation
import Cocoa
import FirebaseAuth

class MainViewController: NSViewController, InProgressVisualizable {
    var inProgress: Bool = false {
        didSet {
            self.setAppearance()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

