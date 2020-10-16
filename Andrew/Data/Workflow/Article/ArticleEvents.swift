//
//  ArticleEvents.swift
//  Andrew
//
//  Created by Sashalmi Imre on 2020. 07. 12..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import Foundation

enum ArticleEvents {
    
    // Preparation
    case baseFolderAdded
    case textAdded
    case imagesAdded
    
    // Designing
    case inddAdded
    case designStarted
    case designCompleted
    case designApproved
    case redesignRequired
    
    // Round1
    case round1Started
    case textCorrected
    case imagesUpdated
    case round1Approved
    
    // Round2
    case round2Started
    case round2Approved
    
    // Finalizing
    case verified
    case print
    case archive
    
    // Markers
    case setAdjustmentRequired
    case removeAdjustmentRequired
    case setDeleted
    case removeDeleted
    case setTextAprovalRequired
    case removeTextAprovalRequired
    case setImageAprovalRequired
    case removeImageAprovalRequired
    case setDesignAprovalRequired
    case removeDesignAprovalRequired
}
