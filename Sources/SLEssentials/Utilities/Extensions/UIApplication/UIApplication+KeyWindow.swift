//
//  UIApplication+KeyWindow.swift
//
//
//  Created by Mirko Licanin on 20.4.22..
//  Copyright © 2022 SwiftyLabs. All rights reserved.
//

import UIKit

public extension UIApplication {
	var firstKeyWindow: UIWindow? {
		UIApplication.shared.windows.first { $0.isKeyWindow }
	}
}
