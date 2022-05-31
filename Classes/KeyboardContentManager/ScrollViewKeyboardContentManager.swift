//
//  ScrollViewKeyboardContentManager.swift
//  SLEssentials
//
//  Created by Vukasin on 2/22/19.
//  Copyright © 2019 SwiftyLabs. All rights reserved.
//

import UIKit

#if os(iOS)
public final class  ScrollViewKeyboardContentManager: KeyboardManageable {
	
	// MARK: - Properties
	
	public var keyboardHides: () -> () = {}
	public var keyboardShows: () -> () = {}
	public var bottomOffsetHeight: CGFloat? = nil
	
	private var notificationCenter: NotificationCenter = .default
	private var scrollView: UIScrollView?
	
	// MARK: - Initialization
	
	public init(scrollView: UIScrollView) {
		self.scrollView = scrollView
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
		if let height = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size.height {
			
			let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: height, right: 0.0)
			scrollView?.contentInset = contentInsets
			scrollView?.scrollIndicatorInsets = contentInsets
			keyboardShows()
		}
	}
	
	@objc func keyboardWillHide(_ notification: Notification) {
		keyboardHides()
		scrollView?.contentInset = .zero
		scrollView?.scrollIndicatorInsets = .zero
	}
}
#endif
