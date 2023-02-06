//
//  UIStackView+RemoveSubviews.swift
//
//
//  Created by Mirko Licanin on 11.8.21..
//  Copyright © 2021 SwiftyLabs. All rights reserved.
//

import UIKit

public extension UIStackView {
	func removeSubviews() {
		subviews.forEach { $0.removeFromSuperview() }
	}
}
