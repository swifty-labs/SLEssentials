//
//  ImageLoader.swift
//
//
//  Created by Slobodan Ristic on 3.2.23..
//  Copyright © 2023 SwiftyLabs. All rights reserved.
//

import UIKit

protocol ImageLoader {
	func setImage(with url: URL?)
	func setImage(with url: URL?, placeholder: UIImage?)
	func setImage(with url: URL?, placeholder: UIImage?, completion: VoidReturnClosure<Result<UIImage, ImageError>>?)
}

extension ImageLoader {
	func setImage(with url: URL?) {
		setImage(with: url, placeholder: nil, completion: nil)
	}

	func setImage(with url: URL?, placeholder: UIImage?) {
		setImage(with: url, placeholder: placeholder, completion: nil)
	}
}

enum ImageError: Error {
	case download(Error)
	case unknown

	init(_ error: Error?) {
		if let error {
			self = .download(error)
		} else {
			self = .unknown
		}
	}
}
