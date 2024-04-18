//
//  FeedLoaderStub.swift
//  EssentialAppTests
//
//  Created by Romeo Flauta on 4/18/24.
//

import EssentialFeed

class FeedLoaderStub: FeedLoader {
	private let result: FeedLoader.Result

	init(result: FeedLoader.Result) {
		self.result = result
	}

	func load(completion: @escaping (FeedLoader.Result) -> Void) {
		completion(result)
	}
}
