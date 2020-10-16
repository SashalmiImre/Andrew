//
//  ArticleEventHandler.swift
//  Andrew
//
//  Created by Sashalmi Imre on 2020. 07. 12..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import Foundation

protocol ArticleEventHandler {
    var state: ArticleStates { get set }
}

extension ArticleEventHandler {
    mutating func handler(event: ArticleEvents) {
        switch (self.state, event) {
            
        // Preparation
        case (.preparationInProgress ..< .preparationDone, .baseFolderAdded):
            self.state.insert(.hasBaseFolder)
            
        case (.preparationInProgress ..< .preparationDone, .textAdded):
            self.state.insert(.hasText)
            
        case (.preparationInProgress ..< .preparationDone, .imagesAdded):
            self.state.insert(.hasImages)
            
            
        // Designing
        case (.preparationInProgress ... [.preparationInProgress, .designInProgress], .inddAdded):
            self.state.insert(.hasInDesignFile)
        
        case (.preparationDone ... [.designInProgress, .hasInDesignFile], .designStarted):
            self.state.insert(.designStarted)
            
        case ([.designInProgress, .hasInDesignFile], .designCompleted):
            self.state.insert(.designEnded)
            
        case ([.designInProgress, .hasInDesignFile, .designEnded], .designApproved):
            self.state.insert(.designApproved)
            
        case ([.designInProgress, .hasInDesignFile, .designEnded], .redesignRequired):
            self.state = [.designInProgress, .hasInDesignFile]
            
            
        // Round1
        case (.designDone, .round1Started):
            self.state.insert(.round1Started)
            
        case (.round1InProgress ..< .round1Done, .textCorrected):
            self.state.insert(.textCorrected)
            
        case (.round1InProgress ..< .round1Done, .imagesUpdated):
            self.state.insert(.imagesUpdated)
            
        case (.round1InProgress ..< .round1Done, .round1Approved):
            self.state.insert(.round1Approved)
            
        case (.round1InProgress ..< .round1Done, .redesignRequired):
            self.state = [.designInProgress, .hasInDesignFile]
            
            
        // Round2
        case (.round1Done, .round2Started):
            self.state.insert(.round2InProgress)
            
        case (.round2InProgress, .round2Approved):
            self.state.insert(.round2Approved)
            
            
        // Finalizing
        case (.round2Done, .verified):
            self.state.insert(.fullyVerified)
            
        case (.sendable, .print):
            self.state.insert(.printed)
            
        case(.archivable, .archive):
            self.state.insert(.closed)
            
            
        // Markers
        case (.preparationInProgress ..< .workflowEnd, .setAdjustmentRequired):
            self.state.insert(.adjustmentRequired)
            
        case (.preparationInProgress ..< [.workflowEnd, .adjustmentRequired], .removeAdjustmentRequired):
            self.state.remove(.adjustmentRequired)
            
        case (.preparationInProgress ..< .workflowEnd, .setDeleted):
            self.state.insert(.deleted)
            
        case (.preparationInProgress ..< [.workflowEnd, .deleted], .removeDeleted):
            self.state.remove(.deleted)
            
            
            
        case (_, _):
            break
        }
    }
}
