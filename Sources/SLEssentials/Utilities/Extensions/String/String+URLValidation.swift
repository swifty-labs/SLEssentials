//
//  String+URLValidation.swift
//
//
//  Created by Mirko Licanin on 9.13.20..
//  Copyright © 2020 SwiftyLabs. All rights reserved.
//

import Foundation

public extension String {
	var isValidURL: Bool {
		guard let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue) else { return false }
		guard let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) else { return false }
		return match.range.length == self.utf16.count
	}
}
