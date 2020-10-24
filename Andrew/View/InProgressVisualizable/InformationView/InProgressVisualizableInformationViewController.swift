//
//  InProgressVisualizableInformationViewController.swift
//  Andrew
//
//  Created by Sashalmi Imre on 2020. 10. 23..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import Foundation
import Cocoa

class InProgressVisualizableInformationViewController: NSViewController {
    @IBOutlet weak var progressBar: NSProgressIndicator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.progressBar.startAnimation(nil)
    }
}
