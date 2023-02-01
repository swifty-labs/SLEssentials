//
//  Array+Sorting.swift
//
//
//  Created by Milos Stankovic on 17.6.22..
//  Copyright © 2022 SwiftyLabs. All rights reserved.
//

import Foundation

extension Array {
	func sorted<T: Comparable>(by keyPath: KeyPath<Element, T?>, using comparator: (T, T) -> Bool = (<) ) -> [Element] {
		sorted { firstElement, secondElement in
			guard let first = firstElement[keyPath: keyPath] else { return false }
			guard let second = secondElement[keyPath: keyPath] else { return true }
			
			return comparator(first, second)
		}
	}
	
	func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>, using comparator: (T, T) -> Bool = (<) ) -> [Element] {
		sorted { firstElement, secondElement in
			comparator(firstElement[keyPath: keyPath], secondElement[keyPath: keyPath])
		}
	}
}
