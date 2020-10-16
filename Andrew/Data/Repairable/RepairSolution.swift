//
//  RepairSolution.swift
//  Andrew
//
//  Created by Sashalmi Imre on 2020. 09. 08..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import Foundation

typealias RepairSolution<T: Repairable> = (T, RepairArguments?) -> Result<Any?, T.RepairErrorType>
