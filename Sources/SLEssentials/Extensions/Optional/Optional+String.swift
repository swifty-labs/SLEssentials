//
//  Optional+String.swift
//
//
//  Created by Mirko Licanin on 6.1.20..
//  Copyright © 2020 SwiftyLabs. All rights reserved.
//

public extension Optional where Wrapped == String {
	var isNilOrEmpty: Bool {
		self?.isEmpty ?? true
	}
}
