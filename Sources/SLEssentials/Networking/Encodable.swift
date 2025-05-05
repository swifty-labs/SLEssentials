//
//  Encodable.swift
//  SLEssentials
//
//  Created by Slobodan Ristic on 5. 5. 2025..
//

import Foundation

public extension Encodable {
	var queryItems: [URLQueryItem]? {
		let encoder = JSONEncoder()
		encoder.keyEncodingStrategy = .convertToSnakeCase
		guard let data = try? encoder.encode(self) else { return nil }
		return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments))
			.flatMap { $0 as? [String: Any] }?
			.compactMap { URLQueryItem(name: $0.0, value: String(describing: $0.1)) }
	}
}
