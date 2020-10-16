//
//  PublicationValidatable.swift
//  Andrew
//
//  Created by Sashalmi Imre on 2020. 08. 10..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import Foundation

extension Publication: Validatable {
    typealias ValidationErrorType = PublicationValidationError
    
    func validationSteps() -> [ValidationStep<Publication>] {
        return [
            Publication.checkHomeFolder,
            Publication.checkDesignedSubFolder,
            Publication.checkPDFSubFolder,
            Publication.checkCorrectedSubFolder,
            Publication.checkPrintableSubFolder,
            Publication.checkPrintedSubFolder,
            Publication.checkRetouchSubFolder
        ]
    }
}

extension Publication {
    
    static func checkHomeFolder(_ publication: Publication) -> ValidationResult<Publication.ValidationErrorType> {
        guard publication.homeFolder != nil else { return .error(.homeFolderNotSet)}
        guard FileManager.default.fileExists(atPath: publication.homeFolder!.path) else {
            return .error(.homeFolderNotFound)
        }
        return .success
    }
    
    static func checkDesignedSubFolder(_ publication: Publication) -> ValidationResult<Publication.ValidationErrorType> {
        guard publication.designedURL != nil else { return .warning(.designedSubfolderNotSet)}
        guard FileManager.default.fileExists(atPath: publication.designedURL!.path) else {
            return .warning(.designedSubfolderNotFound)
        }
        return .success
    }
    
    static func checkPDFSubFolder(_ publication: Publication) -> ValidationResult<Publication.ValidationErrorType> {
        guard publication.pdfURL != nil else { return .warning(.pdfSubfolderNotSet)}
        guard FileManager.default.fileExists(atPath: publication.pdfURL!.path) else {
            return .warning(.pdfSubfolderNotFound)
        }
        return .success
    }
    
    static func checkCorrectedSubFolder(_ publication: Publication) -> ValidationResult<Publication.ValidationErrorType> {
        guard publication.correctedURL != nil else { return .warning(.correctedSubfolderNotSet)}
        guard FileManager.default.fileExists(atPath: publication.correctedURL!.path) else {
            return .warning(.correctedSubfolderNotFound)
        }
        return .success
    }
    
    static func checkPrintableSubFolder(_ publication: Publication) -> ValidationResult<Publication.ValidationErrorType> {
        guard publication.printableURL != nil else { return .warning(.printableSubfolderNotSet)}
        guard FileManager.default.fileExists(atPath: publication.printableURL!.path) else {
            return .warning(.printableSubfolderNotFound)
        }
        return .success
    }
    
    static func checkPrintedSubFolder(_ publication: Publication) -> ValidationResult<Publication.ValidationErrorType> {
        guard publication.printedURL != nil else { return .warning(.printedSubfolderNotSet)}
        guard FileManager.default.fileExists(atPath: publication.printedURL!.path) else {
            return .warning(.printedSubfolderNotFound)
        }
        return .success
    }
    
    static func checkRetouchSubFolder(_ publication: Publication) -> ValidationResult<Publication.ValidationErrorType> {
        guard publication.retouchURL != nil else { return .warning(.retouchSubfolderNotSet)}
        guard FileManager.default.fileExists(atPath: publication.retouchURL!.path) else {
            return .warning(.retouchSubfolderNotFound)
        }
        return .success
    }
}
