//
//  RepairableProtocol.swift
//  Andrew
//
//  Created by Sashalmi Imre on 2020. 09. 02..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import Foundation
import Cocoa

protocol Repairable {
    associatedtype ValidationErrorType: ValidationError & Hashable
    associatedtype RepairErrorType: RepairError
    
    func solutions() -> Dictionary<ValidationErrorType, RepairSolution<Self>>
}

extension Repairable {
    func repair(for error: ValidationErrorType, arguments: RepairArguments? = nil) -> Result<Any?, RepairErrorType>? {
        guard let solution = self.solutions()[error] else { return nil }
        return solution(self, arguments)
    }
}
