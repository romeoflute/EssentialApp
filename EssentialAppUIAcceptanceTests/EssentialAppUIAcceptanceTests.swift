//
//  EssentialAppUIAcceptanceTests.swift
//  EssentialAppUIAcceptanceTests
//
//  Created by Romeo Flauta on 4/19/24.
//

import XCTest

final class EssentialAppUIAcceptanceTests: XCTestCase {
    func test_onLaunch_displaysRemoteFeedWhenCustomerHasConnectivity() {
		let app = XCUIApplication()

		app.launch()
        
        _ = app.cells.firstMatch.waitForExistence(timeout: 1.0)
        _ = app.cells.firstMatch.staticTexts["FeedImage"].firstMatch.waitForExistence(timeout: 1.0)
                
        XCTAssertEqual(app.cells.count, 22)
        XCTAssertEqual(app.cells.firstMatch.images.count, 1)
	}
}
