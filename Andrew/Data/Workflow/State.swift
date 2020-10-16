//
//  State.swift
//  Andrew
//
//  Created by Sashalmi Imre on 2020. 08. 05..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import Foundation

protocol State: OptionSet, Comparable { }

extension State where RawValue: BinaryInteger {
    static func < (lhs: Self, rhs: Self) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}
