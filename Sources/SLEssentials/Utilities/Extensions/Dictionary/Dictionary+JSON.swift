//
//  Dictionary+JSON.swift
//
//
//  Created by Mirko Licanin on 19.7.22..
//  Copyright © 2022 SwiftyLabs. All rights reserved.
//

import Foundation

public extension Dictionary where Key == String {
	func toJSONString(prettyPrinted: Bool = false) -> String? {
		guard JSONSerialization.isValidJSONObject(self) else { return nil }
		let options: JSONSerialization.WritingOptions = prettyPrinted ? [.prettyPrinted, .sortedKeys] : [.sortedKeys]
		guard let data = try? JSONSerialization.data(withJSONObject: self, options: options) else { return nil }
		return String(data: data, encoding: .utf8)
	}
}
