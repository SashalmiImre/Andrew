//
//  FinalizingTests.swift
//  AndrewTests
//
//  Created by Sashalmi Imre on 2020. 07. 20..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import XCTest
@testable import Andrew

class FinalizationTests: XCTestCase {
    static var testMock: ArticleEventHandlerMock!
    
    override class func setUp() {
        testMock = ArticleEventHandlerMock()
        testMock.state = .round2Done
    }
    
    // MARK: - Normal situations
    
    func test01_Verification() throws {
        FinalizationTests.testMock.handler(event: .verified)
        XCTAssertEqual(FinalizationTests.testMock.state, .sendable)
    }
    
    func test02_Printing() throws {
        FinalizationTests.testMock.handler(event: .print)
        XCTAssertEqual(FinalizationTests.testMock.state, .archivable)
    }
    
    func test03_Archiving() throws {
        FinalizationTests.testMock.handler(event: .archive)
        XCTAssertEqual(FinalizationTests.testMock.state, .workflowEnd)
    }
    
    
    // Markers
    func test07_SetAndRemoveAdjustmentRequiredMarker() throws {
        FinalizationTests.testMock.handler(event: .setAdjustmentRequired)
        XCTAssertFalse(FinalizationTests.testMock.state.contains(.adjustmentRequired))
    }
    
    func test08_SetAndRemoveDeletedMarker() throws {
        FinalizationTests.testMock.handler(event: .setDeleted)
        XCTAssertFalse(FinalizationTests.testMock.state.contains(.deleted))
    }
}
