//
//  Array+Replace.swift
//
//
//  Created by Mirko Licanin on 4.5.20..
//  Copyright © 2020 SwiftyLabs. All rights reserved.
//

import Foundation

public extension Array {
	mutating func replaceElement(at index: Index, with newElement: Element) {
		self.remove(at: index)
		self.insert(newElement, at: index)
	}
}

public extension Array where Element: Equatable {
	mutating func replace(_ element: Element, with newElement: Element) {
		guard let oldElementIndex = self.firstIndex(of: element) else {return}
		self.replaceElement(at: oldElementIndex, with: newElement)
	}
}
