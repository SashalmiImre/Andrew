//
//  DesigningTests.swift
//  AndrewTests
//
//  Created by Sashalmi Imre on 2020. 07. 16..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import XCTest
@testable import Andrew

class DesigningTests: XCTestCase {
    static var testMock: ArticleEventHandlerMock!
    
    override class func setUp() {
        testMock = ArticleEventHandlerMock()
        testMock.state = .preparationDone
    }
    
    // MARK: - Normal situations
    
    func test01_SetInDesignFileAddedMarker() throws {
        DesigningTests.testMock.handler(event: .inddAdded)
        XCTAssertTrue(DesigningTests.testMock.state.contains(.hasInDesignFile))
    }
    
    func test02_StartDesigning() throws {
        DesigningTests.testMock.handler(event: .designStarted)
        XCTAssertEqual(DesigningTests.testMock.state, [.designInProgress, .hasInDesignFile])
    }
    
    func test03_DesignIsComplete() throws {
        DesigningTests.testMock.handler(event: .designCompleted)
        XCTAssertEqual(DesigningTests.testMock.state, [.designInProgress, .hasInDesignFile, .designEnded])
    }
    
    func test04_DesignIsDone() throws {
        DesigningTests.testMock.handler(event: .designApproved)
        XCTAssertEqual(DesigningTests.testMock.state, .designDone)
    }
    
    // Markers
    func test05_SetAndRemoveAdjustmentRequiredMarker() throws {
        DesigningTests.testMock.handler(event: .setAdjustmentRequired)
        XCTAssertTrue(DesigningTests.testMock.state.contains(.adjustmentRequired))
        
        DesigningTests.testMock.handler(event: .removeAdjustmentRequired)
        XCTAssertFalse(DesigningTests.testMock.state.contains(.adjustmentRequired))
    }
    
    func test06_SetAndRemoveDeletedMarker() throws {
        DesigningTests.testMock.handler(event: .setDeleted)
        XCTAssertTrue(DesigningTests.testMock.state.contains(.deleted))
        
        DesigningTests.testMock.handler(event: .removeDeleted)
        XCTAssertFalse(DesigningTests.testMock.state.contains(.deleted))
    }
    
    // MARK: - Special situations
    
    func test07_RedesignRequired() throws {
        DesigningTests.testMock.state = [.designInProgress, .hasInDesignFile, .designEnded]
        DesigningTests.testMock.handler(event: .redesignRequired)
        XCTAssertEqual(DesigningTests.testMock.state, [.designInProgress, .hasInDesignFile])
    }
}
