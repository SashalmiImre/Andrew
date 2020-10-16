//
//  PublicationEventHandler.swift
//  Andrew
//
//  Created by Sashalmi Imre on 2020. 08. 04..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import Foundation


protocol PublicationEventHandler {
    var state: PublicationStates { get set }
}

extension PublicationEventHandler {
    mutating func handler(event: PublicationEvents) {
        switch (self.state, event) {
            
        case(_, .baseFolderAdded):
            self.state.insert(.hasBaseFolder)
            
        case (.hasBaseFolder ..< .allFoldersCreated, .designedSubfolderAdded):
            self.state.insert(.hasDesignedSubfolder)
            
        case (.hasBaseFolder ..< .allFoldersCreated, .correctedSubfolderAdded):
            self.state.insert(.hasCorrectedSubfolder)
            
        case (.hasBaseFolder ..< .allFoldersCreated, .printableSubfolderAdded):
            self.state.insert(.hasPrintableSubfolder)
            
        case (.hasBaseFolder ..< .allFoldersCreated, .printedSubfolderAdded):
            self.state.insert(.hasPrintedSubfolder)
            
        case (.hasBaseFolder ..< .allFoldersCreated, .pdfSubfolderAdded):
            self.state.insert(.hasPDFSubfolder)
        
        case (_, _):
            break
        }
    }
}
