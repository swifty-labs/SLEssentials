//
//  Array+Remove.swift
//
//
//  Created by Slobodan Ristic on 2.2.23..
//  Copyright © 2023 SwiftyLabs. All rights reserved.
//

import Foundation

public extension Array {
	mutating func removeFirst(where matcher: (Self.Element) throws -> Bool) rethrows -> Element? {
		guard let index = try self.firstIndex(where: matcher) else { return nil }
		return self.remove(at: index)
	}
}
