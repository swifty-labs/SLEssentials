//
//  UIView+Embed.swift
//
//
//  Created by Mirko Licanin on 22.1.20..
//  Copyright © 2020 SwiftyLabs. All rights reserved.
//

import UIKit
import TinyConstraints

public extension UIView {
	func embed(_ controller: UIViewController, into targetView: UIView? = nil, useSafeArea: Bool = false) {
		controller.view.translatesAutoresizingMaskIntoConstraints = false
		controller.view.clipsToBounds = true

		let viewContainer = targetView ?? self
		viewContainer.addSubview(controller.view)

		let safeAreaInsets = useSafeArea ? UIApplication.shared.safeAreaInsets : .zero
		controller.view.edgesToSuperview(insets: .init(top: safeAreaInsets.top, left: 0.0, bottom: safeAreaInsets.bottom, right: 0.0))

		layoutIfNeeded()
	}
}
