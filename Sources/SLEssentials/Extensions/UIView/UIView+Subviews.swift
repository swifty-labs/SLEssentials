//
//  UIView+Subviews.swift
//
//
//  Created by Mirko Licanin on 5.16.19..
//  Copyright © 2019 SwiftyLabs. All rights reserved.
//

import UIKit

public extension UIView {
	func clearSubviews() {
		for subview in self.subviews {
			subview.removeFromSuperview()
		}
	}
}
