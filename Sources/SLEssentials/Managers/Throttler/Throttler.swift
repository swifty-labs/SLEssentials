//
//  Throttler.swift
//
//
//  Created by Mirko Licanin on 16.11.21..
//  Copyright © 2021 SwiftyLabs. All rights reserved.
//

import Foundation

public final class Throttler {
	// MARK: - Properties

	private let delay: TimeInterval
	private var timer: Timer?
	private var block: NoArgsClosure?

	// MARK: - Initialization

	public init(delay: TimeInterval) {
		self.delay = delay
	}

	deinit {
		block = nil
		timer?.invalidate()
	}

	// MARK: - Public methods

	public func schedule(_ block: @escaping NoArgsClosure) {
		guard timer?.isValid != true else {
			self.block = block
			return
		}
		block()
		timer = Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { [weak self] _ in
			guard let self, let block = self.block else { return }
			self.block = nil
			self.timer?.invalidate()
			self.schedule(block)
		}
	}
}
