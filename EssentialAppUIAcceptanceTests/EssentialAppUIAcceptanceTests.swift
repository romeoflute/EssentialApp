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
        app.launchArguments = ["-reset, -connectivity", "online"]
        app.launch()
        
        let cells = app.cells.matching(identifier: "FeedImageCell")
        let images = cells.firstMatch.images.matching(identifier: "FeedImageView")
        if cells.element.waitForExistence(timeout: 1.0) {
            XCTAssertEqual(cells.count, 22)
            XCTAssertEqual(images.count, 1)
        } else {
            XCTFail("Expected to complete with 22 cells")
        }
    }
    
    func test_onLaunch_displaysCachedRemoteFeedWhenCustomerHasNoConnectivity() {
        let onlineApp = XCUIApplication()
        onlineApp.launchArguments = ["-reset, -connectivity", "online"]
        onlineApp.launch()
        
        let offlineApp = XCUIApplication()
        offlineApp.launchArguments = [" -connectivity", "offline"]
        offlineApp.launch()
        
        let cells = offlineApp.cells.matching(identifier: "FeedImageCell")
        let images = cells.firstMatch.images.matching(identifier: "FeedImageView")
        if cells.element.waitForExistence(timeout: 5.0) {
            XCTAssertEqual(cells.count, 22)
            XCTAssertEqual(images.count, 1)
        } else {
            XCTFail("Expected to complete with 22 cells")
        }
    }
    
    func test_onLaunch_displaysEmptyFeedWhenCustomerHasNoConnectivityAndNoCache() {
        let app = XCUIApplication()
        app.launchArguments = ["-reset", "-connectivity", "offline"]
        app.launch()
        
        let offlineApp = XCUIApplication()
        offlineApp.launchArguments = ["-connectivity", "offline"]
        offlineApp.launch()
        
        let cells = offlineApp.cells.matching(identifier: "FeedImageCell")
        let cellsExist = cells.element.waitForExistence(timeout: 1.0)
        
        if cellsExist {
            XCTFail("Expected that cells will not exists but found some")
        } else {
            debugPrint("success as no cells exists")
        }
    }
}
