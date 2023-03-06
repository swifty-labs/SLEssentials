//
//  NSAttributedString+Concatenate.swift
//
//
//  Created by Mirko Licanin on 16.8.21..
//  Copyright © 2021 SwiftyLabs. All rights reserved.
//

import Foundation

public extension NSAttributedString {
	static func + (lhs: NSAttributedString, rhs: NSAttributedString) -> NSAttributedString {
		let text = NSMutableAttributedString()
		text.append(lhs)
		text.append(rhs)
		return text
	}
}
