//
//  Array+Chunked.swift
//
//
//  Created by Mirko Licanin on 11.25.19..
//  Copyright © 2019 SwiftyLabs. All rights reserved.
//

import Foundation

public extension Array {
	func chunked(into size: Int) -> [[Element]] {
		stride(from: 0, to: count, by: size).map {
			Array(self[$0 ..< Swift.min($0 + size, count)])
		}
	}
}
