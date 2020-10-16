//
//  Round2Tests.swift
//  AndrewTests
//
//  Created by Sashalmi Imre on 2020. 07. 19..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import XCTest
@testable import Andrew

class Round2Tests: XCTestCase {
    static var testMock: ArticleEventHandlerMock!
    
    override class func setUp() {
        testMock = ArticleEventHandlerMock()
        testMock.state = .round1Done
    }
    
    // MARK: - Normal situations
    
    func test01_StartRound2() throws {
        Round2Tests.testMock.handler(event: .round2Started)
        XCTAssertEqual(Round2Tests.testMock.state, .round2InProgress)
    }
    
    func test02_RedesignRequired() {
        Round2Tests.testMock.handler(event: .redesignRequired)
        XCTAssertNotEqual(Round2Tests.testMock.state, [.designInProgress, .hasInDesignFile])
    }
    
    func test03_Round2Approved() throws {
        Round2Tests.testMock.handler(event: .round2Approved)
        XCTAssertEqual(Round2Tests.testMock.state, .round2Done)
    }
    
    // Markers
    func test04_SetAndRemoveAdjustmentRequiredMarker() throws {
        Round2Tests.testMock.handler(event: .setAdjustmentRequired)
        XCTAssertTrue(Round2Tests.testMock.state.contains(.adjustmentRequired))
        
        Round2Tests.testMock.handler(event: .removeAdjustmentRequired)
        XCTAssertFalse(Round2Tests.testMock.state.contains(.adjustmentRequired))
    }
    
    func test05_SetAndRemoveDeletedMarker() throws {
        Round2Tests.testMock.handler(event: .setDeleted)
        XCTAssertTrue(Round2Tests.testMock.state.contains(.deleted))
        
        Round2Tests.testMock.handler(event: .removeDeleted)
        XCTAssertFalse(Round2Tests.testMock.state.contains(.deleted))
    }
}
