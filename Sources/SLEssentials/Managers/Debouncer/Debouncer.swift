//
//  Debouncer.swift
//
//
//  Created by Mirko Licanin on 7.6.22..
//  Copyright © 2022 SwiftyLabs. All rights reserved.
//

import Foundation

public final class Debouncer {
	// MARK: - Properties
	
	private let option: DebounceOption
	private let delay: TimeInterval
	private var timer: Timer?
	private var block: NoArgsClosure?
	
	// MARK: - Initialization
	
	public init(option: DebounceOption = .trailing, delay: TimeInterval) {
		self.option = option
		self.delay = delay
	}

	deinit {
		block = nil
		timer?.invalidate()
	}
	
	// MARK: - Public methods
	
	public func schedule(_ block: @escaping NoArgsClosure) {
		switch option {
		case .leading:
			scheduleLeading(block)
		case .trailing:
			scheduleTrailing(block)
		}
	}
	
	// MARK: - Private methods
	
	private func scheduleLeading(_ block: @escaping NoArgsClosure) {
		guard timer?.isValid != true else {
			timer?.invalidate()
			timer = Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { _ in }
			return
		}
		block()
		timer = Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { _ in }
	}
	
	private func scheduleTrailing(_ block: @escaping NoArgsClosure) {
		self.block = block
		timer?.invalidate()
		timer = Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { [weak self] _ in
			guard let self else { return }
			self.block?()
			self.block = nil
		}
	}
}
