//
//  AppStateObserver.swift
//
//
//  Created by Mirko Licanin on 3.7.20..
//  Copyright © 2020 SwiftyLabs. All rights reserved.
//

import UIKit

public final class AppStateObserver: NSObject, AppStateObservable {
	public var foregroundHandler: NoArgsClosure?
	public var backgroundHandler: NoArgsClosure?
	public var terminateHandler: NoArgsClosure?

	// MARK: - Public methods

	public func registerForNotifications() {
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(handleEnterForeground(_:)),
			name: UIApplication.willEnterForegroundNotification,
			object: nil
		)
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(handleEnterBackground(_:)),
			name: UIApplication.didEnterBackgroundNotification,
			object: nil
		)
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(handleTermination(_:)),
			name: UIApplication.willTerminateNotification,
			object: nil
		)
	}

	public func unregisterForNotifications() {
		NotificationCenter.default.removeObserver(self, name: UIApplication.willEnterForegroundNotification, object: nil)
		NotificationCenter.default.removeObserver(self, name: UIApplication.didEnterBackgroundNotification, object: nil)
		NotificationCenter.default.removeObserver(self, name: UIApplication.willTerminateNotification, object: nil)
	}

	// MARK: - Actions

	@objc
	private func handleEnterForeground(_ notification: Notification) {
		foregroundHandler?()
	}

	@objc
	private func handleEnterBackground(_ notification: Notification) {
		backgroundHandler?()
	}

	@objc
	private func handleTermination(_ notification: Notification) {
		terminateHandler?()
	}
}
