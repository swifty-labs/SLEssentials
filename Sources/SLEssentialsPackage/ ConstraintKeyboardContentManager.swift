//
//  ConstraintKeyboardContentManager.swift
//
//
//  Created by Milos Stankovic on 17.6.22..
//  Copyright © 2022 SwiftyLabs. All rights reserved.
//

import UIKit

#if os(iOS)
public final class ConstraintKeyboardContentManager: KeyboardManageable {
	
	// MARK: - Properties
	
	public var bottomOffsetHeight: CGFloat?
	public var keyboardHides: () -> () = {}
	public var keyboardShows: () -> () = {}
	
	private var notificationCenter: NotificationCenter = .default
	private var constraintBottom: NSLayoutConstraint
	private var containerView: UIView
	
	// MARK: - Initialization
	
	public init(containerView: UIView, constraintBottom: NSLayoutConstraint) {
		self.constraintBottom = constraintBottom
		self.containerView = containerView
	}
	
	// MARK: - Public methods
	
	public func registerForKeyboardNotifications() {
		notificationCenter.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
		notificationCenter.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
	}
	
	public func unregisterForKeyboardNotifications() {
		notificationCenter.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
		notificationCenter.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
	}
	
	// MARK: - Actions
	
	@objc func keyboardWillShow(_ notification: Notification) {
		if let userInfo = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
			UIView.animate(withDuration: 0.25, animations: {[weak self] in
				self?.constraintBottom.constant = userInfo.cgRectValue.height - (self?.bottomOffsetHeight ?? 0.0)
			})
			keyboardShows()
		}
	}
	
	@objc func keyboardWillHide(_ notification: Notification) {
		keyboardHides()
		constraintBottom.constant = 0.0
		UIView.animate(withDuration: 0.25, animations: {[weak self] in
			self?.containerView.layoutIfNeeded()
		})
	}
}
#endif
