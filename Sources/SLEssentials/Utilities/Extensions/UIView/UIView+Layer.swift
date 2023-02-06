//
//  UIView+Layer.swift
//
//
//  Created by Mirko Licanin on 17.1.20..
//  Copyright © 2020 SwiftyLabs. All rights reserved.
//

import UIKit

public extension CACornerMask {
	static var all: CACornerMask = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
}

public extension UIView {
	func roundedCorners(radius: CGFloat, corners: CACornerMask = CACornerMask.all) {
		layer.masksToBounds = true
		layer.cornerRadius = radius
		layer.maskedCorners = corners
	}

	func roundedCorners() {
		layer.masksToBounds = true
		layer.cornerRadius = bounds.width / 2.0
		layer.maskedCorners = .all
	}

	func setBorder(width: CGFloat, color: UIColor) {
		layer.borderWidth = width
		layer.borderColor = color.cgColor
	}
	
	func setGradient(start: UIColor, end: UIColor) {
		let layer = CAGradientLayer()
		layer.frame = bounds
		layer.colors = [start.cgColor, end.cgColor]
		self.layer.insertSublayer(layer, at: 0)
	}
}
