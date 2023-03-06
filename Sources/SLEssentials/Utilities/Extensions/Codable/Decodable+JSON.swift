//
//  Decodable+JSON.swift
//
//
//  Created by Mirko Licanin on 29.1.20..
//  Copyright © 2020 SwiftyLabs. All rights reserved.
//

import Foundation

public extension Decodable {
	init?(json: [String: Any]) {
		guard let data = Data(json: json) else { return nil }
		guard let result = try? JSONDecoder().decode(Self.self, from: data) else { return nil }
		self = result
	}

	init?(jsonString: String) {
		guard let data = jsonString.data(using: .utf8) else { return nil }
		guard let result = try? JSONDecoder().decode(Self.self, from: data) else { return nil }
		self = result
	}

	init(fromFile fileName: String = String(describing: Self.self), in bundle: Bundle) {
		guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
			fatalError("Can't find a json file with name: \(fileName)")
		}
		guard let data = try? Data(contentsOf: url) else {
			fatalError("Can't load the data for a json file with name: \(fileName)")
		}
		guard let object = try? JSONDecoder().decode(Self.self, from: data) else {
			fatalError("Can't decode the data for a json file with name: \(fileName)")
		}
		self = object
	}
}
