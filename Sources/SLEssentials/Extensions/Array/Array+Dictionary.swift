//
//  Array+Dictionary.swift
//
//
//  Created by Slobodan Ristic on 2.2.23..
//  Copyright © 2023 SwiftyLabs. All rights reserved.
//

import Foundation

public extension Array {
	var indexedDictionary: [Int: Element] {
		enumerated().reduce(into: [:]) { $0[$1.offset] = $1.element }
	}
}
