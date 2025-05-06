//
//  UserDefaults+Object.swift
//  SLEssentials
//
//  Created by Slobodan Ristic on 6. 5. 2025..
//

import Foundation

extension UserDefaults {
	func getObject<T: Any>(forKey key: String) -> T? {
		object(forKey: key) as? T
	}

	func setObject(_ object: Any?, forKey key: String) {
		set(object, forKey: key)
	}
}
