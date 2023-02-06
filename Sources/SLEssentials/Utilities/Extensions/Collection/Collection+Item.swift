//
//  Collection+Item.swift
//
//
//  Created by Slobodan Ristic on 2.2.23..
//  Copyright © 2023 SwiftyLabs. All rights reserved.
//

import Foundation

public extension Collection {
	/// Returns the element at the specified index if it is within bounds, otherwise nil.
	subscript (safe index: Index) -> Element? {
		indices.contains(index) ? self[index] : nil
	}
}
