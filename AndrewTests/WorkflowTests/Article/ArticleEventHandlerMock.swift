//
//  ArticleEventHandlerMock.swift
//  AndrewTests
//
//  Created by Sashalmi Imre on 2020. 07. 16..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import Foundation
@testable import Andrew

struct ArticleEventHandlerMock: ArticleEventHandler {
    var state: ArticleStates = .preparationInProgress
}
