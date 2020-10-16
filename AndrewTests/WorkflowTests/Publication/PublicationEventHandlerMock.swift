//
//  PublicationEventHandlerMock.swift
//  AndrewTests
//
//  Created by Sashalmi Imre on 2020. 08. 05..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import Foundation
@testable import Andrew

struct PublicationEventHandlerMock: PublicationEventHandler {
    var state: PublicationStates = PublicationStates(rawValue: 0)
}
