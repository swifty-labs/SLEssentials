//
//  LoadingIndicator.swift
//
//
//  Created by Mirko Licanin on 21.8.20..
//  Copyright © 2020 SwiftyLabs. All rights reserved.
//

import UIKit

public enum LoadingStyle {
    case large
    case medium
}

public protocol LoadingIndicator {
    var loadingStyle: LoadingStyle { get set }
	func show(in view: UIView, message: String?)
	func hide()
}

public extension LoadingIndicator {
	func show(in view: UIView) {
		show(in: view, message: nil)
	}
}
