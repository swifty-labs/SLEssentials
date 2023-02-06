//
//  String+Trim.swift
//
//
//  Created by Mirko Licanin on 2.2.21..
//  Copyright © 2021 SwiftyLabs. All rights reserved.
//

import Foundation

public extension String {
	var trimmed: String {
		self.trimmingCharacters(in: .whitespacesAndNewlines)
	}

	var condensed: String {
		components(separatedBy: .whitespaces).joined()
	}
}
