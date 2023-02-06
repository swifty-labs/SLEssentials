//
//  UIViewController+Root.swift
//
//
//  Created by Mirko Licanin on 10.1.22..
//  Copyright © 2022 SwiftyLabs. All rights reserved.
//

import UIKit

public extension UIViewController {
	var isRootViewController: Bool {
		guard let navController = navigationController else { return true }
		return navController.viewControllers.count == 1 && navController.viewControllers.first == self
	}
}
