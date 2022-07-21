//
//  KeyboardManageable.swift
//
//
//  Created by Milos Stankovic on 17.6.22..
//  Copyright © 2022 SwiftyLabs. All rights reserved.
//

import UIKit

#if os(iOS)
public protocol KeyboardManageable: AnyObject {
	
	// MARK: - Properties
	
	var keyboardHides: () -> () { get set }
	var keyboardShows: () -> () { get set }
	var bottomOffsetHeight: CGFloat? { get set }
	
	// MARK: - Public methods
	
	func registerForKeyboardNotifications()
	func unregisterForKeyboardNotifications()
}
#endif
