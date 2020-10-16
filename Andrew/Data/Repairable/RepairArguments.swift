//
//  RepairArguments.swift
//  Andrew
//
//  Created by Sashalmi Imre on 2020. 09. 09..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import Foundation

typealias RepairArguments = Dictionary<String, Any>

extension RepairArguments {
    func value<T>(forKey key: String, type: T.Type) -> T? {
        guard let value = self[key] as? T else { return nil }
        return value
    }
}
