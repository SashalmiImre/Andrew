//
//  ReachabilityDelegate.swift
//  Andrew
//
//  Created by Sashalmi Imre on 2019. 03. 18..
//  Copyright © 2019. Sashalmi Imre. All rights reserved.
//

import Foundation

protocol ReachabilityDelegate: AnyObject {
    func handler(_ handler: Reachability, stateDidChange event: Reachability.Event)
}
