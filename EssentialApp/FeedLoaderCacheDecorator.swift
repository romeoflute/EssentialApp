//
//  FeedLoaderCacheDecorator.swift
//  EssentialApp
//
//  Created by Romeo Flauta on 4/19/24.
//

import Foundation
import EssentialFeed

// Lesson: The loader (with load func) is separate from the cache (with save function and thus does have a side effect). This decorator pattern adds the saving behavior to the loader decoratee without changing the original loader
public final class FeedLoaderCacheDecorator: FeedLoader {
	private let decoratee: FeedLoader
	private let cache: FeedCache

	public init(decoratee: FeedLoader, cache: FeedCache) {
		self.decoratee = decoratee
		self.cache = cache
	}

	public func load(completion: @escaping (FeedLoader.Result) -> Void) {
		decoratee.load { [weak self] result in
			completion(result.map { feed in
				self?.cache.save(feed) { _ in }
				return feed
			})
		}
	}
}
