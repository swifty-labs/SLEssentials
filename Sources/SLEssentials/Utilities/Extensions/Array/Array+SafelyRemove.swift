//
//  Array+SafelyRemove.swift
//
//
//  Created by Mirko Licanin on 8.1.21..
//  Copyright © 2021 SwiftyLabs. All rights reserved.
//

import Foundation

public extension Array {
	@discardableResult mutating func safeRemoveFirst() -> Element? {
		guard !self.isEmpty else { return nil }
		return self.removeFirst()
	}
}

public extension Array {
	@discardableResult mutating func safeRemoveLast() -> Element? {
		guard !self.isEmpty else { return nil }
		return self.removeLast()
	}
}
