//
//  Encodable+Dictionary.swift
//
//
//  Created by Mirko Licanin on 5.20.19..
//  Copyright © 2019 SwiftyLabs. All rights reserved.
//

import Foundation

public extension Encodable {
	var dictionary: [String: Any]? {
		guard let data = try? JSONEncoder().encode(self) else { return nil }
		return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
	}
}
