//
//  KeyboardManager.swift
//
//
//  Created by Mirko Licanin on 17.1.20..
//  Copyright © 2020 SwiftyLabs. All rights reserved.
//

import UIKit

#if os(iOS)
public final class KeyboardManager {
	// MARK: - Properties

	public var offset = UIApplication.shared.bottomSafeAreaHeight
	public var onHeightChange: VoidReturnClosure<CGFloat>?
	public var onOpen: NoArgsClosure?
	public var willClose: NoArgsClosure?
	public var onClose: NoArgsClosure?

	private lazy var keyboardAccessoryView = KeyboardAccessoryView()

	// MARK: - Initialization

	public init() {
		registerForKeyboardNotifications()
	}

	public init(textView: UITextView) {
		bind()
		textView.inputAccessoryView = keyboardAccessoryView
		registerForKeyboardNotifications()
	}

	deinit {
		unregisterForKeyboardNotifications()
	}

	// MARK: - Actions

	@objc
	func keyboardWillBeShown(_ notification: Notification) {
		if let heightOfKeyboard = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size.height {
			onHeightChange?(max(0, heightOfKeyboard))
			onOpen?()
		}
	}

	@objc
	func keyboardWillBeHidden(_ notification: Notification) {
		onHeightChange?(0.0)
		willClose?()
	}

	@objc
	func keyboardDidHide(_ notification: Notification) {
		onClose?()
	}

	// MARK: - Private methods

	private func registerForKeyboardNotifications() {
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(keyboardWillBeShown(_:)),
			name: UIResponder.keyboardWillShowNotification,
			object: nil
		)
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(keyboardWillBeHidden(_:)),
			name: UIResponder.keyboardWillHideNotification,
			object: nil
		)
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(keyboardDidHide(_:)),
			name: UIResponder.keyboardDidHideNotification,
			object: nil
		)
	}

	private func unregisterForKeyboardNotifications() {
		NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
		NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)
	}

	private func bind() {
		keyboardAccessoryView.onFrameChange = { [weak self] frame in
			guard let self else { return }
			let height = UIScreen.main.bounds.height - frame.minY - self.offset
			self.onHeightChange?(max(0, height))
		}
	}
}
#endif
