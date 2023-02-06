//
//  Data+JSON.swift
//
//
//  Created by Mirko Licanin on 29.1.20..
//  Copyright © 2020 SwiftyLabs. All rights reserved.
//

import Foundation

public extension Data {
	var json: [String: Any]? {
		try? JSONSerialization.jsonObject(with: self, options: .allowFragments) as? [String: Any]
	}
	
	var isCompleteJSON: Bool {
		let jsonString = String(data: self, encoding: .utf8)
		let openBracesCount = jsonString?
			.filter { $0 == "{" }
			.count
		let closedBracesCount = jsonString?
			.filter { $0 == "}" }
			.count
		return openBracesCount == closedBracesCount
	}
	
	init?(json: [String: Any], prettyPrinted: Bool = true) {
		guard let data = try? JSONSerialization.data(withJSONObject: json, options: prettyPrinted ? .prettyPrinted : []) else {
			return nil
		}
		self = data
	}
}
