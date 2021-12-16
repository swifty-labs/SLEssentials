//
//  Array+Sorting.swift
//  StratosJets
//
//  Created by Vukasin Popovic on 14.12.21..
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
