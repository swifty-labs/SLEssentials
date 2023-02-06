//
//  Dictionary+Merge.swift
//
//
//  Created by Mirko Licanin on 24.12.21..
//  Copyright © 2021 SwiftyLabs. All rights reserved.
//

public extension Dictionary {
	mutating func merge(_ other: [Key: Value]?) {
		guard let other else { return }
		merge(other) { _, new in new }
	}
}
