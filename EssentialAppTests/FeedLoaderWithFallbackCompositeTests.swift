//
//  FeedLoaderWithFallbackCompositeTests.swift
//  EssentialAppTests
//
//  Created by Romeo Flauta on 4/18/24.
//

import XCTest
import EssentialFeed
import EssentialApp

class FeedLoaderWithFallbackCompositeTests: XCTestCase, FeedLoaderTestCase {

	func test_load_deliversPrimaryFeedOnPrimaryLoaderSuccess() {
		let primaryFeed = uniqueFeed()
		let fallbackFeed = uniqueFeed()
        
        let sut = makeSUT(primaryResult: .success(primaryFeed), fallbackResult: .success(fallbackFeed))

		expect(sut, toCompleteWith: .success(primaryFeed))
	}
    
    func test_load_deliversFallbackFeedOnPrimaryLoaderFailure() {
		let fallbackFeed = uniqueFeed()
		let sut = makeSUT(primaryResult: .failure(anyNSError()), fallbackResult: .success(fallbackFeed))

		expect(sut, toCompleteWith: .success(fallbackFeed))
	}
    
    func test_load_deliversErrorOnBothPrimaryAndFallbackLoaderFailure() {
		let sut = makeSUT(primaryResult: .failure(anyNSError()), fallbackResult: .failure(anyNSError()))

		expect(sut, toCompleteWith: .failure(anyNSError()))
	}
    
    // MARK: - Helpers

	private func makeSUT(primaryResult: FeedLoader.Result, fallbackResult: FeedLoader.Result, file: StaticString = #file, line: UInt = #line) -> FeedLoader {
		let primaryLoader = LoaderStub(result: primaryResult)
		let fallbackLoader = LoaderStub(result: fallbackResult)
		let sut = FeedLoaderWithFallbackComposite(primary: primaryLoader, fallback: fallbackLoader)
		trackForMemoryLeaks(primaryLoader, file: file, line: line)
		trackForMemoryLeaks(fallbackLoader, file: file, line: line)
		trackForMemoryLeaks(sut, file: file, line: line)
		return sut
	}

	private class LoaderStub: FeedLoader {
		private let result: FeedLoader.Result

		init(result: FeedLoader.Result) {
			self.result = result
		}

		func load(completion: @escaping (FeedLoader.Result) -> Void) {
			completion(result)
		}
	}

}
