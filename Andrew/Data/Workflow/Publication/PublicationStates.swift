//
//  PublicationStates.swift
//  Andrew
//
//  Created by Sashalmi Imre on 2020. 07. 26..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import Foundation

struct PublicationStates: State {
    let rawValue: Int32
    
    static let hasBaseFolder         = PublicationStates(rawValue: 1 << 0)  // 1
    static let hasDesignedSubfolder  = PublicationStates(rawValue: 1 << 1)  // 2
    static let hasCorrectedSubfolder = PublicationStates(rawValue: 1 << 2)  // 4
    static let hasPrintableSubfolder = PublicationStates(rawValue: 1 << 3)  // 8
    static let hasPrintedSubfolder   = PublicationStates(rawValue: 1 << 4)  // 16
    static let hasPDFSubfolder       = PublicationStates(rawValue: 1 << 5)  // 32
    
    static let allFoldersCreated: PublicationStates = [.hasBaseFolder, .hasDesignedSubfolder,
                                                       .hasPrintableSubfolder, .hasPrintedSubfolder,
                                                       .hasPDFSubfolder]
}
