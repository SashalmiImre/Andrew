//
//  MainWindowController.swift
//  Andrew
//
//  Created by Sashalmi Imre on 2020. 09. 13..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import Foundation
import Cocoa

class MainWindowController: NSWindowController {

    override init(window: NSWindow?) {
        super.init(window: window)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
        
    override func windowDidLoad() {
        super.windowDidLoad()
        guard let window = self.window else { return }
        window.backgroundColor = .clear
        window.isOpaque = false
    }
}
