//
//  UISwitch+OffTint.swift
//
//
//  Created by Mirko Licanin on 5.3.19..
//  Copyright © 2019 SwiftyLabs. All rights reserved.
//

import UIKit

#if os(iOS)
public extension UISwitch {
	func setOffTintColor(_ color: UIColor) {
		tintColor = color
		layer.cornerRadius = 16
		backgroundColor = color
	}
}
#endif
