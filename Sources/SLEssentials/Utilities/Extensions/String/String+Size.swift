//
//  String+Size.swift
//
//
//  Created by Mirko Licanin on 25.5.21..
//  Copyright © 2021 SwiftyLabs. All rights reserved.
//

import UIKit

public extension String {
	func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
		let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
		let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)

		return ceil(boundingBox.height)
	}

	func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
		let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
		let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)

		return ceil(boundingBox.width)
	}
}
