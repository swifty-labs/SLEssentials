//
//  AppStateObservable.swift
//
//
//  Created by Mirko Licanin on 3.7.20..
//  Copyright © 2020 SwiftyLabs. All rights reserved.
//

public protocol AppStateObservable {
	var foregroundHandler: NoArgsClosure? { get set }
	var backgroundHandler: NoArgsClosure? { get set }
	var terminateHandler: NoArgsClosure? { get set }
	func registerForNotifications()
	func unregisterForNotifications()
}
