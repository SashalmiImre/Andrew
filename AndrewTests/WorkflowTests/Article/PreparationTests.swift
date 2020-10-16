//
//  PreparationTests.swift
//  AndrewTests
//
//  Created by Sashalmi Imre on 2020. 07. 12..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import XCTest
@testable import Andrew

class PreparationTests: XCTestCase {
    static var testMock: ArticleEventHandlerMock!
    
    override class func setUp() {
        testMock = ArticleEventHandlerMock()
    }
    
    // MARK: - Normal situations
    
    func test01_AddBaseFolder() throws {
        PreparationTests.testMock.handler(event: .baseFolderAdded)
        XCTAssertEqual(PreparationTests.testMock.state, [.preparationInProgress, .hasBaseFolder])
    }
    
    func test01_AddText() throws {
        PreparationTests.testMock.handler(event: .textAdded)
        XCTAssertEqual(PreparationTests.testMock.state, [.preparationInProgress, .hasBaseFolder, .hasText])
    }
    
    func test02_AddImages() throws {
        PreparationTests.testMock.handler(event: .imagesAdded)
        XCTAssertEqual(PreparationTests.testMock.state, .preparationDone)
    }
    
    // Reverse order
    func test03_AddImages() throws {
        PreparationTests.testMock = ArticleEventHandlerMock()
        PreparationTests.testMock.handler(event: .baseFolderAdded)
        PreparationTests.testMock.handler(event: .imagesAdded)
        XCTAssertEqual(PreparationTests.testMock.state, [.preparationInProgress, .hasBaseFolder, .hasImages])
    }
    
    func test04_AddText() throws {
        PreparationTests.testMock.handler(event: .textAdded)
        XCTAssertEqual(PreparationTests.testMock.state, .preparationDone)
    }
    
    // Has INDD-file marker
    func test06_SetInDesignFileAddedMarker() throws {
        PreparationTests.testMock.handler(event: .inddAdded)
        XCTAssertTrue(PreparationTests.testMock.state.contains(.hasInDesignFile))
    }
    
    // Markers
    func test06_SetAndRemoveAdjustmentRequiredMarker() throws {
        PreparationTests.testMock.handler(event: .setAdjustmentRequired)
        XCTAssertTrue(PreparationTests.testMock.state.contains(.adjustmentRequired))
        
        PreparationTests.testMock.handler(event: .removeAdjustmentRequired)
        XCTAssertFalse(PreparationTests.testMock.state.contains(.adjustmentRequired))
    }
    
    func test07_SetAndRemoveDeletedMarker() throws {
        PreparationTests.testMock.handler(event: .setDeleted)
        XCTAssertTrue(PreparationTests.testMock.state.contains(.deleted))
        
        PreparationTests.testMock.handler(event: .removeDeleted)
        XCTAssertFalse(PreparationTests.testMock.state.contains(.deleted))
    }
    
    // MARK: - Special situations
    func test08_RedesignRequired() throws {
        PreparationTests.testMock.handler(event: .redesignRequired)
        XCTAssertNotEqual(PreparationTests.testMock.state, [.designInProgress, .hasInDesignFile])
    }
}
