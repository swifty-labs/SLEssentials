//
//  UIImage+Resize.swift
//
//
//  Created by Mirko Licanin on 9.2.22..
//  Copyright © 2022 SwiftyLabs. All rights reserved.
//

import UIKit

public extension UIImage {
	/// It will resize the image to the provided size by sampling it
	/// with sample size that is a power of 2 while keeping image
	/// width and height greater or equal to the provided size while maintaining
	/// original image aspect ratio
	func resized(to size: CGSize = .init(width: 480.0, height: 480.0)) -> UIImage? {
		let sampleSize = sampleSize(requestedSize: size)
		guard sampleSize > 1 else { return self }
		let size = CGSize(width: self.size.width / sampleSize, height: self.size.height / sampleSize)
		UIGraphicsBeginImageContext(size)
		draw(in: CGRect(origin: .zero, size: size))
		let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return resizedImage
	}
	
	/// Calculates sample size as a power of two
	/// https://developer.android.com/topic/performance/graphics/load-bitmap
	private func sampleSize(requestedSize: CGSize) -> CGFloat {
		var sampleSize: CGFloat = 1
		guard size.width > requestedSize.width || size.height > requestedSize.height else { return sampleSize }
		let halfWidth = size.width / 2
		let halfHeight = size.height / 2
		// Calculate the largest sampleSize value that is a power of 2 and keeps both
		// height and width larger than the requested height and width.
		while (halfWidth / sampleSize) >= requestedSize.width && (halfHeight / sampleSize) >= requestedSize.height {
			sampleSize *= 2
		}
		return sampleSize
	}
}
