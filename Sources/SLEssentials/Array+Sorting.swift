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
		sorted { a, b in
			guard let first = a[keyPath: keyPath] else { return false }
			guard let second = b[keyPath: keyPath] else { return true }
			
			return comparator(first, second)
		}
	}
	
	func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>, using comparator: (T, T) -> Bool = (<) ) -> [Element] {
		sorted { a, b in
			comparator(a[keyPath: keyPath], b[keyPath: keyPath])
		}
	}
}
