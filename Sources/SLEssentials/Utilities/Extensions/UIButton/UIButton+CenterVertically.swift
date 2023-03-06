//
//  UIButton+CenterVertically.swift
//
//
//  Created by Mirko Licanin on 2.1.19..
//  Copyright © 2019 SwiftyLabs. All rights reserved.
//

import UIKit

public extension UIButton {
	func centerVertically(padding: CGFloat = 5.0) {
		guard let sizeImageView = self.imageView?.frame.size, let sizeLabel = self.titleLabel?.frame.size else { return }
		let totalHeight = sizeImageView.height + sizeLabel.height + padding
		imageEdgeInsets = UIEdgeInsets(top: -(totalHeight - sizeImageView.height), left: 0.0, bottom: 0.0, right: -sizeLabel.width)
		titleEdgeInsets = UIEdgeInsets(top: 0.0, left: -sizeImageView.width, bottom: -(totalHeight - sizeLabel.height), right: 0.0)
	}
}
