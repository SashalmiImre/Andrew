//
//  ValidationTests.swift
//  AndrewTests
//
//  Created by Sashalmi Imre on 2020. 08. 10..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import XCTest
@testable import Andrew

class ValidationTests: XCTestCase {

    static var testEnvironment: TestEnvironment!
    
    override class func setUp() {
        testEnvironment = TestEnvironment()
    }
    
    override class func tearDown() {
        testEnvironment.removeFolders()
    }
    
    override func setUp() {
        self.continueAfterFailure = false
    }
    
    func test01_HomeFolderIsSetted() throws {
        let publication = Publication(homeFolder: ValidationTests.testEnvironment.homeFolder,
                                      context: ValidationTests.testEnvironment.dbContext)
        publication.homeFolder = nil
        
        let result = publication.validate()
        
        XCTAssertNotNil(result)
        XCTAssertEqual(result!, [.error(.homeFolderNotSet)])
    }
    
//    func test02_HomeFolderIsExists() throws {
//        let publication = Publication(homeFolder: ValidationTests.testEnvironment.homeFolder,
//                                      context: ValidationTests.testEnvironment.dbContext)
//        ValidationTests.testEnvironment.deleteHomeFolder()
//
//        let validator = PublicationValidator.build()
//        var result = validator.validate(publication).simplified
//        
//        XCTAssertNotNil(result?.error)
//        XCTAssertEqual(result!.error!, .homeFolderNotFound)
//        
//        ValidationTests.testEnvironment.createFolders()
//        result = validator.validate(publication).simplified
//        XCTAssertNil(result)
//    }
//    
//    func test03_DesignedSubFolderIsSetted() throws {
//        let publication = Publication(homeFolder: ValidationTests.testEnvironment.homeFolder,
//                                      context: ValidationTests.testEnvironment.dbContext)
//        publication.designedSubfolder = nil
//        
//        let validator = PublicationValidator.build()
//        var result = validator.validate(publication).simplified
//        
//        XCTAssertNotNil(result?.warnings)
//        XCTAssertEqual(result!.warnings!, [.designedSubfolderNotSet])
//        
//        publication.designedSubfolder = "__TORDELVE"
//        result = validator.validate(publication).simplified
//        
//        XCTAssertNil(result)
//    }
//    
//    func test04_DesignedSubFolderIsExists() throws {
//        let publication = Publication(homeFolder: ValidationTests.testEnvironment.homeFolder,
//                                      context: ValidationTests.testEnvironment.dbContext)
//        ValidationTests.testEnvironment.deleteDesignedSubFolder()
//        
//        let validator = PublicationValidator.build()
//        var result = validator.validate(publication).simplified
//        
//        XCTAssertNotNil(result?.warnings)
//        XCTAssertEqual(result!.warnings!, [.designedSubfolderNotFound, .correctedSubfolderNotFound,
//                                           .printableSubfolderNotFound, .printedSubfolderNotFound])
//        
//        ValidationTests.testEnvironment.createFolders()
//        result = validator.validate(publication).simplified
//        
//        XCTAssertNil(result)
//    }
//    
//    func test05_PDFSubFolderIsSetted() throws {
//        let publication = Publication(homeFolder: ValidationTests.testEnvironment.homeFolder,
//                                      context: ValidationTests.testEnvironment.dbContext)
//        publication.pdfSubfolder = nil
//        
//        let validator = PublicationValidator.build()
//        var result = validator.validate(publication).simplified
//        
//        XCTAssertNotNil(result?.warnings)
//        XCTAssertEqual(result!.warnings!, [.pdfSubfolderNotSet])
//
//        publication.pdfSubfolder = "__PDF"
//        result = validator.validate(publication).simplified
//        
//        XCTAssertNil(result)
//    }
//    
//    func test06_PDFSubFolderIsExists() throws {
//        let publication = Publication(homeFolder: ValidationTests.testEnvironment.homeFolder,
//                                      context: ValidationTests.testEnvironment.dbContext)
//        ValidationTests.testEnvironment.deletePDFSubFolder()
//        
//        let validator = PublicationValidator.build()
//        var result = validator.validate(publication).simplified
//        
//        XCTAssertNotNil(result?.warnings)
//        XCTAssertEqual(result!.warnings!, [.pdfSubfolderNotFound])
//        
//        ValidationTests.testEnvironment.createFolders()
//        result = validator.validate(publication).simplified
//        
//        XCTAssertNil(result)
//    }
//    
//    func test07_CorrectedSubFolderIsSetted() throws {
//        let publication = Publication(homeFolder: ValidationTests.testEnvironment.homeFolder,
//                                      context: ValidationTests.testEnvironment.dbContext)
//        publication.correctedSubfolder = nil
//        
//        let validator = PublicationValidator.build()
//        var result = validator.validate(publication).simplified
//        
//        XCTAssertNotNil(result?.warnings)
//        XCTAssertEqual(result!.warnings!, [.correctedSubfolderNotSet])
//
//        publication.correctedSubfolder = "__TORDELVE/__OLVASVA"
//        result = validator.validate(publication).simplified
//        
//        XCTAssertNil(result)
//    }
//    
//    func test08_CorrectedSubFolderIsExists() throws {
//        let publication = Publication(homeFolder: ValidationTests.testEnvironment.homeFolder,
//                                      context: ValidationTests.testEnvironment.dbContext)
//        ValidationTests.testEnvironment.deleteCorrectedSubFolder()
//        
//        let validator = PublicationValidator.build()
//        var result = validator.validate(publication).simplified
//        
//        XCTAssertNotNil(result?.warnings)
//        XCTAssertEqual(result!.warnings!, [.correctedSubfolderNotFound,
//                                           .printableSubfolderNotFound, .printedSubfolderNotFound])
//        
//        ValidationTests.testEnvironment.createFolders()
//        result = validator.validate(publication).simplified
//        
//        XCTAssertNil(result)
//    }
//    
//    func test09_PrintableSubFolderIsSetted() throws {
//        let publication = Publication(homeFolder: ValidationTests.testEnvironment.homeFolder,
//                                      context: ValidationTests.testEnvironment.dbContext)
//        publication.printableSubfolder = nil
//        
//        let validator = PublicationValidator.build()
//        var result = validator.validate(publication).simplified
//        
//        XCTAssertNotNil(result?.warnings)
//        XCTAssertEqual(result!.warnings!, [.printableSubfolderNotSet])
//
//        publication.printableSubfolder = "__TORDELVE/__OLVASVA/__LEVILAGITHATO"
//        result = validator.validate(publication).simplified
//        
//        XCTAssertNil(result)
//    }
//    
//    func test10_PrintableSubFolderIsExists() throws {
//        let publication = Publication(homeFolder: ValidationTests.testEnvironment.homeFolder,
//                                      context: ValidationTests.testEnvironment.dbContext)
//        ValidationTests.testEnvironment.deletePrintableSubFolder()
//        
//        let validator = PublicationValidator.build()
//        var result = validator.validate(publication).simplified
//        
//        XCTAssertNotNil(result?.warnings)
//        XCTAssertEqual(result!.warnings!, [.printableSubfolderNotFound])
//        
//        ValidationTests.testEnvironment.createFolders()
//        result = validator.validate(publication).simplified
//        
//        XCTAssertNil(result)
//    }
//    
//    func test11_PrintedSubFolderIsSetted() throws {
//        let publication = Publication(homeFolder: ValidationTests.testEnvironment.homeFolder,
//                                      context: ValidationTests.testEnvironment.dbContext)
//        publication.printedSubfolder = nil
//        
//        let validator = PublicationValidator.build()
//        var result = validator.validate(publication).simplified
//        
//        XCTAssertNotNil(result?.warnings)
//        XCTAssertEqual(result!.warnings!, [.printedSubfolderNotSet])
//
//        publication.printedSubfolder = "__TORDELVE/__OLVASVA/__LEVIL"
//        result = validator.validate(publication).simplified
//        
//        XCTAssertNil(result)
//    }
//    
//    func test12_PrintedSubFolderIsExists() throws {
//        let publication = Publication(homeFolder: ValidationTests.testEnvironment.homeFolder,
//                                      context: ValidationTests.testEnvironment.dbContext)
//        ValidationTests.testEnvironment.deletePrintedSubFolder()
//        
//        let validator = PublicationValidator.build()
//        var result = validator.validate(publication).simplified
//        
//        XCTAssertNotNil(result?.warnings)
//        XCTAssertEqual(result!.warnings!, [.printedSubfolderNotFound])
//        
//        ValidationTests.testEnvironment.createFolders()
//        result = validator.validate(publication).simplified
//        
//        XCTAssertNil(result)
//    }
}
