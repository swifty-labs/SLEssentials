//
//  UIViewController+Embed.swift
//
//
//  Created by Milos Stankovic on 17.6.22..
//  Copyright © 2022 SwiftyLabs. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {	
	public func embed(viewController child: UIViewController, in containerView: UIView? = nil) {
		addChild(child)
		
		guard let refView = containerView ?? view else {
			fatalError("There is no parent view")
		}
		refView.addSubview(child.view)
		
		child.view.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			child.view.topAnchor.constraint(equalTo: refView.topAnchor, constant: 0),
			child.view.bottomAnchor.constraint(equalTo: refView.bottomAnchor, constant: 0),
			child.view.leftAnchor.constraint(equalTo: refView.leftAnchor, constant: 0),
			child.view.rightAnchor.constraint(equalTo: refView.rightAnchor, constant: 0)
		])
		
		child.didMove(toParent: self)
	}
	
	public func embed(viewController child: UIViewController, withFrame frame: CGRect, in containerView: UIView? = nil) {
		
		child.view.frame = frame
		addChild(child)
		guard let refView = containerView ?? view else {
			fatalError("There is no parent view")
		}
		refView.addSubview(child.view)
		child.didMove(toParent: self)
	}
	
	public func unembed() {
		guard isViewLoaded else {
			return
		}
		willMove(toParent: nil)
		view.removeFromSuperview()
		removeFromParent()
	}
}
