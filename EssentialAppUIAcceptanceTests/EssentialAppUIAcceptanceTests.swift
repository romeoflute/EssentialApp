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
        
        if app.cells.firstMatch.images.matching(identifier: "FeedImage").element.waitForExistence(timeout: 1.0) && app.cells.matching(identifier: "FeedImageCell").element.waitForExistence(timeout: 1.0) {
            let feedCells = app.cells.matching(identifier: "FeedImageCell")
            let firstCell = feedCells.firstMatch
            XCTAssertEqual(feedCells.count, 22)
            XCTAssertEqual(firstCell.images.count, 22)
        }
	}
}