//
//  Array+Appending.swift
//
//
//  Created by Slobodan Ristic on 2.2.23..
//  Copyright © 2023 SwiftyLabs. All rights reserved.
//

import Foundation

public extension Array {
	func appending(_ items: Array) -> Array {
		self + items
	}
}
