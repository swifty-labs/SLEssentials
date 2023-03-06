//
//  Dictionary+Equal.swift
//
//
//  Created by Mirko Licanin on 15.9.20..
//  Copyright © 2020 SwiftyLabs. All rights reserved.
//

import Foundation

public extension Dictionary where Key == String, Value == Any {
	static func == (lhs: [Key: Value], rhs: [Key: Value]) -> Bool {
		NSDictionary(dictionary: lhs).isEqual(to: rhs)
	}
}
