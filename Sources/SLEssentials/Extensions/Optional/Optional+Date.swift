//
//  Optional+Date.swift
//
//
//  Created by Mirko Licanin on 17.5.21..
//  Copyright © 2021 SwiftyLabs. All rights reserved.
//

import Foundation

public extension Optional where Wrapped == Date {
	static func > (lhs: Date?, rhs: Date?) -> Bool {
		guard let lhs else { return false }
		guard let rhs else { return true }
		return lhs > rhs
	}
}
