//
//  WorkflowHandler.swift
//  Andrew
//
//  Created by Sashalmi Imre on 2020. 07. 12..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import Foundation

protocol WorkflowEventHandler {
    var state: WorkflowStates { get set }
}

extension WorkflowEventHandler {
    mutating func handler(event: WorkflowEvent) {
        switch (self.state, event) {
            
        // Preparation
        case (.preparationInProgress ..< .preparationDone, .textAdded):
            self.state.insert(.hasText)
            
        case (.preparationInProgress ..< .preparationDone, .imagesAdded):
            self.state.insert(.hasImages)
            
            
        // Designing
        case (.preparationInProgress ... [.preparationInProgress, .designInProgress], .inddAdded):
            self.state.insert(.hasInDesignFile)
        
        case (.preparationDone ... [.designInProgress, .hasInDesignFile], .startDesigning):
            self.state.insert(.designStarted)
            
        case ([.designInProgress, .hasInDesignFile], .designIsComplete):
            self.state.insert(.designEnded)
            
        case ([.designInProgress, .hasInDesignFile, .designEnded], .designApproved):
            self.state.insert(.designApproved)
            
        case ([.designInProgress, .hasInDesignFile, .designEnded], .redesignRequired):
            self.state = .preparationDone
            
            
        // Round1
        case (.designDone, .startRound1):
            self.state.insert(.round1Started)
            
        case (.round1InProgress ..< .round1Done, .textCorrected):
            self.state.insert(.textCorrected)
            
        case (.round1InProgress ..< .round1Done, .imagesUpdated):
            self.state.insert(.imagesUpdated)
            
        case (.round1InProgress ..< .round1Done, .round1Approved):
            self.state.insert(.round1Approved)
            
            
        // Round2
        case (.round1Done, .startRound2):
            self.state.insert(.round2InProgress)
            
        case (.round2InProgress, .round2Approved):
            self.state.insert(.round2Approved)
            
            
        // Markers
        case (_, .setAdjustmentRequiredMarker):
            self.state.insert(.adjustmentRequired)
            
        case (_, .removeAdjustmentRequiredMarker):
            self.state.remove(.adjustmentRequired)
            
        case (_, .setDeletedMarker):
            self.state.insert(.deleted)
            
        case (_, .removeDeletedMarker):
            self.state.remove(.deleted)
            
            
            
        case (_, _):
            break
        }
    }
}
