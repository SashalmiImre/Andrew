//
//  Round1Test.swift
//  AndrewTests
//
//  Created by Sashalmi Imre on 2020. 07. 19..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import XCTest
@testable import Andrew

class Round1Tests: XCTestCase {
    static var testMock: ArticleEventHandlerMock!
    
    override class func setUp() {
        testMock = ArticleEventHandlerMock()
        testMock.state = .designDone
    }
    
    // MARK: - Normal situations
    
    func test01_StartRound1() throws {
        Round1Tests.testMock.handler(event: .round1Started)
        XCTAssertEqual(Round1Tests.testMock.state, .round1InProgress)
    }
    
    // First (textCorrected -> imagesUpdated)
    func test02_TextCorrected() throws {
        Round1Tests.testMock.handler(event: .textCorrected)
        XCTAssertEqual(Round1Tests.testMock.state, [.round1InProgress, .textCorrected])
    }
    
    func test03_ImagesUpdated() throws {
        Round1Tests.testMock.handler(event: .imagesUpdated)
        XCTAssertEqual(Round1Tests.testMock.state, [.round1InProgress, .textCorrected, .imagesUpdated])
    }
    
    // Reverse order (imagesUpdated -> textCorrected)
    func test04_ImagesUpdated() throws {
        Round1Tests.testMock.state = .round1InProgress
        Round1Tests.testMock.handler(event: .imagesUpdated)
        XCTAssertEqual(Round1Tests.testMock.state, [.round1InProgress, .imagesUpdated])
    }
    
    func test05_TextCorrected() throws {
        Round1Tests.testMock.handler(event: .textCorrected)
        XCTAssertEqual(Round1Tests.testMock.state, [.round1InProgress, .imagesUpdated, .textCorrected])
    }
    
    func test06_Round1Approved() throws {
        Round1Tests.testMock.handler(event: .round1Approved)
        XCTAssertEqual(Round1Tests.testMock.state, .round1Done)
    }
    
    // Markers
    func test07_SetAndRemoveAdjustmentRequiredMarker() throws {
        Round1Tests.testMock.handler(event: .setAdjustmentRequired)
        XCTAssertTrue(Round1Tests.testMock.state.contains(.adjustmentRequired))
        
        Round1Tests.testMock.handler(event: .removeAdjustmentRequired)
        XCTAssertFalse(Round1Tests.testMock.state.contains(.adjustmentRequired))
    }
    
    func test08_SetAndRemoveDeletedMarker() throws {
        Round1Tests.testMock.handler(event: .setDeleted)
        XCTAssertTrue(Round1Tests.testMock.state.contains(.deleted))
        
        Round1Tests.testMock.handler(event: .removeDeleted)
        XCTAssertFalse(Round1Tests.testMock.state.contains(.deleted))
    }
    
    // MARK: - Special situations
    
    func test07_RedesignRequired() throws {
        Round1Tests.testMock.handler(event: .redesignRequired)
        XCTAssertNotEqual(Round1Tests.testMock.state, [.designInProgress, .hasInDesignFile])
        
        Round1Tests.testMock.state.remove(.round1Approved)
        Round1Tests.testMock.handler(event: .redesignRequired)
        XCTAssertEqual(Round1Tests.testMock.state, [.designInProgress, .hasInDesignFile])
    }
}
