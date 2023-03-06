//
//  UIApplication+Insets.swift
//
//
//  Created by Mirko Licanin on 10.7.20..
//  Copyright © 2020 SwiftyLabs. All rights reserved.
//

import UIKit

public extension UIApplication {
	var safeAreaInsets: UIEdgeInsets {
		UIApplication.shared.firstKeyWindow?.safeAreaInsets ?? .zero
	}
	
	var bottomSafeAreaHeight: CGFloat {
		safeAreaInsets.bottom
	}
}
