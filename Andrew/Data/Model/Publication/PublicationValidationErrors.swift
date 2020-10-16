//
//  PublicationValidationErrors.swift
//  Andrew
//
//  Created by Sashalmi Imre on 2020. 08. 10..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import Foundation

enum PublicationValidationError: ValidationError {
    case homeFolderNotSet
    case homeFolderNotFound
    case designedSubfolderNotSet
    case designedSubfolderNotFound
    case correctedSubfolderNotSet
    case correctedSubfolderNotFound
    case printableSubfolderNotSet
    case printableSubfolderNotFound
    case printedSubfolderNotSet
    case printedSubfolderNotFound
    case pdfSubfolderNotSet
    case pdfSubfolderNotFound
    case retouchSubfolderNotSet
    case retouchSubfolderNotFound
}

extension PublicationValidationError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .homeFolderNotSet:
            return NSLocalizedString("Nincs beállítva alapkönyvtár!", comment: "")
        case .homeFolderNotFound:
            return NSLocalizedString("Nem elérhető az alapkönyvtár!", comment: "")
        case .designedSubfolderNotSet:
            return NSLocalizedString("Nincs beállítva a tördelt fájlok könyvtára!", comment: "")
        case .designedSubfolderNotFound:
            return NSLocalizedString("Nem elérhető a tördelt fájlok könyvtára!", comment: "")
        case .correctedSubfolderNotSet:
            return NSLocalizedString("Nincs beállítva a korrektúrázott anyagok könyvtára!", comment: "")
        case .correctedSubfolderNotFound:
            return NSLocalizedString("Nem elérhető a korrektúrázott anyagok könyvtára!", comment: "")
        case .printableSubfolderNotSet:
            return NSLocalizedString("Nincs beállítva a levilágítható anyagok könyvtára!", comment: "")
        case .printableSubfolderNotFound:
            return NSLocalizedString("Nem elérhető a levilágítható anyagok könyvtára!", comment: "")
        case .printedSubfolderNotSet:
            return NSLocalizedString("Nincs beállítva a levilágított anyagok könyvtára!", comment: "")
        case .printedSubfolderNotFound:
            return NSLocalizedString("Nem elérhető a levilágított anyagok könyvtára!", comment: "")
        case .pdfSubfolderNotSet:
            return NSLocalizedString("Nincs beállítva a PDF fájlok könyvtára!", comment: "")
        case .pdfSubfolderNotFound:
            return NSLocalizedString("Nem elérhető a PDF fájlok könyvtára!", comment: "")
        case .retouchSubfolderNotSet:
            return NSLocalizedString("Nincs beállítva a repró könyvtára!", comment: "")
        case .retouchSubfolderNotFound:
            return NSLocalizedString("Nem elérhető a repró könyvtára!", comment: "")
        }
    }
}

