//
//  ArticleState.swift
//  Andrew
//
//  Created by Sashalmi Imre on 2020. 07. 12..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import Foundation

extension Article: ArticleEventHandler {
    var state: ArticleStates {
        get { return ArticleStates(rawValue: self.stateRawValue) }
        set { self.stateRawValue = newValue.rawValue }
    }
}


