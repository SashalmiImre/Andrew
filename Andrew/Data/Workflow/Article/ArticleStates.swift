//
//  ArticleStates.swift
//  Andrew
//
//  Created by Sashalmi Imre on 2020. 07. 12..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import Foundation

struct ArticleStates: State {
    let rawValue: Int32
    
    // Preparation
    static let preparationInProgress            = ArticleStates(rawValue: 1 << 0)                  // 1
    static let hasBaseFolder                    = ArticleStates(rawValue: 1 << 1)                  // 2
    static let hasText                          = ArticleStates(rawValue: 1 << 2)                  // 4
    static let hasImages                        = ArticleStates(rawValue: 1 << 3)                  // 8
    static let preparationDone: ArticleStates  = [.preparationInProgress, .hasBaseFolder,
                                                  .hasText, .hasImages]                            // 15
    
    // Designing
    static let designStarted                    = ArticleStates(rawValue: 1 << 4)                  // 16
    static let designInProgress: ArticleStates = [.preparationDone, .designStarted]                // 31
    static let hasInDesignFile                  = ArticleStates(rawValue: 1 << 5)                  // 32
    static let designEnded                      = ArticleStates(rawValue: 1 << 6)                  // 64
    static let designApproved                   = ArticleStates(rawValue: 1 << 7)                  // 128
    static let designDone: ArticleStates       = [.designInProgress, .hasInDesignFile,
                                                   .designEnded, .designApproved]                  // 254
    // First round
    static let round1Started                    = ArticleStates(rawValue: 1 << 8)                  // 256
    static let round1InProgress: ArticleStates = [.designDone, .round1Started]                     // 511
    static let round1Approved                   = ArticleStates(rawValue: 1 << 9)                  // 512
    static let textCorrected                    = ArticleStates(rawValue: 1 << 10)                 // 1024
    static let imagesUpdated                    = ArticleStates(rawValue: 1 << 11)                 // 2048
    static let round1Done: ArticleStates       = [.round1InProgress, .round1Approved,
                                                   .textCorrected, .imagesUpdated]                 // 4095
    // Second round
    static let round2Started                    = ArticleStates(rawValue: 1 << 12)                 // 4096
    static let round2InProgress: ArticleStates = [.round1Done, .round2Started]                     // 8191
    static let round2Approved                   = ArticleStates(rawValue: 1 << 13)                 // 8192
    static let round2Done: ArticleStates       = [.round2InProgress, .round2Approved]              // 16383
    
    // Finalizing
    static let fullyVerified                    = ArticleStates(rawValue: 1 << 14)                 // 16384
    static let sendable: ArticleStates         = [.round2Done, .fullyVerified]                     // 32767
    static let printed                          = ArticleStates(rawValue: 1 << 15)                 // 32768
    static let archivable: ArticleStates       = [.sendable, .printed]                             // 65535
    static let closed                           = ArticleStates(rawValue: 1 << 16)                 // 65536
    static let workflowEnd: ArticleStates      = [.archivable, .closed]                            // 131071
    
    
    // Markers
    static let adjustmentRequired               = ArticleStates(rawValue: 1 << 17)                 // 131072
    static let deleted                          = ArticleStates(rawValue: 1 << 18)                 // 262144
    static let textApprovalRequired             = ArticleStates(rawValue: 1 << 19)                 // 524288
    static let imageApprovalRequired            = ArticleStates(rawValue: 1 << 20)                 // 1048576
    static let designApprovalRequired           = ArticleStates(rawValue: 1 << 21)                 // 2097152

    
    func progressLevel() -> ArticleStateGroups {
        switch self {
        case .sendable ... .workflowEnd:
            return .finalizing
        case .round2InProgress ... .round2Done:
            return .round2
        case .round1InProgress ... .round1Done:
            return .round1
        case .designInProgress ... .designDone:
            return .designing
        default:
            return .preparation
        }
    }
}
