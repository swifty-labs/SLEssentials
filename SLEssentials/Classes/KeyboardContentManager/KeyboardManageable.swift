//
//  KeyboardManageable.swift
//  SLEssentials
//
//  Created by Mirko Licanin on 3/4/18.
//  Copyright © 2018 SwifyLabs. All rights reserved.
//

import UIKit

#if os(iOS)    
public protocol KeyboardManageable: class {
	
	// MARK: - Properties
	
	var keyboardHides: () -> () { get set }
	var keyboardShows: () -> () { get set }
	var bottomOffsetHeight: CGFloat? { get set }
	
	// MARK: - Public methods
	
	func registerForKeyboardNotifications()
	func unregisterForKeyboardNotifications()
}
#endif
