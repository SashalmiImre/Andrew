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
    static var testMock: Mock!
    
    override class func setUp() {
        testMock = Mock()
        testMock.state = .designDone
    }
    
    // MARK: - Normal situations
    
    func test01_StartRound1() throws {
        Round1Tests.testMock.handler(event: .startRound1)
        XCTAssertEqual(Round1Tests.testMock.state, .round1InProgress)
    }
    
    func test02_TextCorrected() throws {
        Round1Tests.testMock.handler(event: .textCorrected)
        XCTAssertEqual(Round1Tests.testMock.state, [.round1InProgress, .textCorrected])
    }
    
    func test03_ImagesUpdated() throws {
        Round1Tests.testMock.handler(event: .imagesUpdated)
        XCTAssertEqual(Round1Tests.testMock.state, [.round1InProgress, .textCorrected, .imagesUpdated])
    }
    
    // Reverse order
    func test04_ImagesUpdated() throws {
        Round1Tests.testMock.state = .round1InProgress
        Round1Tests.testMock.handler(event: .imagesUpdated)
        XCTAssertEqual(Round1Tests.testMock.state, [.round1InProgress, .imagesUpdated])
    }
    
    func test05_TextCorrected() throws {
        Round1Tests.testMock.handler(event: .textCorrected)
        XCTAssertEqual(Round1Tests.testMock.state, [.round1InProgress, .imagesUpdated, .textCorrected])
    }
}
