//
//  PublicationStateTests.swift
//  AndrewTests
//
//  Created by Sashalmi Imre on 2020. 08. 05..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import XCTest
@testable import Andrew

class PublicationStateTests: XCTestCase {
    static var testMock: PublicationEventHandlerMock!
    
    override class func setUp() {
        testMock = PublicationEventHandlerMock()
    }
    
    func test01_SetBaseFolder() throws {
        PublicationStateTests.testMock.handler(event: .baseFolderAdded)
        XCTAssertTrue(PublicationStateTests.testMock.state.contains(.hasBaseFolder))
        XCTAssertFalse(PublicationStateTests.testMock.state.contains(.allFoldersCreated))
    }
    
    func test02_SetDesignedSubfolder() throws {
        PublicationStateTests.testMock.handler(event: .designedSubfolderAdded)
        XCTAssertTrue(PublicationStateTests.testMock.state.contains(.hasDesignedSubfolder))
        XCTAssertFalse(PublicationStateTests.testMock.state.contains(.allFoldersCreated))
    }
    
    func test04_SetPrintableSubfolder() throws {
        PublicationStateTests.testMock.handler(event: .printableSubfolderAdded)
        XCTAssertTrue(PublicationStateTests.testMock.state.contains(.hasPrintableSubfolder))
        XCTAssertFalse(PublicationStateTests.testMock.state.contains(.allFoldersCreated))
    }
    
    func test05_SetPrintedSubfolder() throws {
        PublicationStateTests.testMock.handler(event: .printedSubfolderAdded)
        XCTAssertTrue(PublicationStateTests.testMock.state.contains(.hasPrintedSubfolder))
        XCTAssertFalse(PublicationStateTests.testMock.state.contains(.allFoldersCreated))
    }
    
    func test03_SetCorrectedSubfolder() throws {
        PublicationStateTests.testMock.handler(event: .correctedSubfolderAdded)
        XCTAssertTrue(PublicationStateTests.testMock.state.contains(.hasCorrectedSubfolder))
        XCTAssertFalse(PublicationStateTests.testMock.state.contains(.allFoldersCreated))
    }
    
    func test06_SetPDFSubfolder() throws {
        PublicationStateTests.testMock.handler(event: .pdfSubfolderAdded)
        XCTAssertTrue(PublicationStateTests.testMock.state.contains(.hasPDFSubfolder))
    }
    
    func test07_AllFoldersCreated() throws {
        XCTAssertTrue(PublicationStateTests.testMock.state.contains(.allFoldersCreated))
    }
}
