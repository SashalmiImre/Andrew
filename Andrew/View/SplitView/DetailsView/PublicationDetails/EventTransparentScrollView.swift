//
//  EventTransparentScrollView.swift
//  Andrew
//
//  Created by Sashalmi Imre on 2020. 08. 26..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import Foundation
import Cocoa

class EventTransparentScrollView: NSScrollView {
    override func scrollWheel(with event: NSEvent) {
        self.nextResponder?.scrollWheel(with: event)
    }
}
