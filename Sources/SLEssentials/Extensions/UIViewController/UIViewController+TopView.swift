//
//  UIViewController+TopView.swift
//
//
//  Created by Mirko Licanin on 21.11.19..
//  Copyright © 2019 SwiftyLabs. All rights reserved.
//

import UIKit

public extension UIViewController {
	var topViewController: UIViewController {
		if let navigation = self.presentedViewController as? UINavigationController, let visible = navigation.visibleViewController {
			return visible.topViewController
		} else if let presented = self.presentedViewController {
			return presented.topViewController
		} else {
			return self
		}
	}
}

public extension UIApplication {
    var topViewController: UIViewController? {
        firstKeyWindow?.rootViewController?.topViewController
    }
}
