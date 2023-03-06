//
//  AsyncDebouncer.swift
//
//
//  Created by Mirko Licanin on 7.6.22..
//  Copyright © 2022 SwiftyLabs. All rights reserved.
//

import Foundation

public final class AsyncDebouncer<T: Debouncable> {
	// MARK: - Properties

	private let delay: TimeInterval
	private var timer: Timer?
	private var block: VoidReturnClosure<Result<T.Response, Error>>?
	
	// MARK: - Initialization

	public init(delay: TimeInterval = 10.0) {
		self.delay = delay
	}

	deinit {
		block = nil
		timer?.invalidate()
		Logger.logDeinit()
	}

	// MARK: - Public methods

	/// When schedule is called it checks if a request is already in flight.
	/// If another request is in flight, but is older than 'delay' seconds,
	/// the old request (the one that's already in flight) is cancelled & the new request is honored.
	/// If another request is in flight, but is NOT older than 'delay' seconds,
	/// then the new request is discarded & never launched - i.e. the new one is considered a duplicate
	public func schedule(_ debouncable: T, _ block: @escaping VoidReturnClosure<Result<T.Response, Error>>) {
		if timer?.isValid == true {
			self.block = block
			return
		} else if self.block != nil {
			self.block = nil
			timer?.invalidate()
			schedule(debouncable, block)
		}
		else {
			self.block = block
			debouncable.consume { [weak self] completion in
				guard let self else { return }
				self.block?(completion)
				self.block = nil
				self.timer?.invalidate()
			}
			timer = Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { _ in }
		}
	}
}

public protocol Debouncable {
	associatedtype Response: Decodable

	func consume(completion: @escaping VoidReturnClosure<Result<Response, Error>>)
}
