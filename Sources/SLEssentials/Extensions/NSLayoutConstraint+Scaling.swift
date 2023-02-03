//
//  NSLayoutConstraint+Scaling.swift
//
//
//  Created by Milos Stankovic on 17.6.22..
//  Copyright © 2022 SwiftyLabs. All rights reserved.
//

import Foundation
import UIKit

public enum AxialRatio {
	case vertical, horizontal
}

extension NSLayoutConstraint {
	var horizontalRatio: CGFloat {
        UIScreen.main.bounds.width / 414.0
	}
	var verticalRatio: CGFloat {
        UIScreen.main.bounds.height / 896.0
	}

	public func adjust(for ratio: AxialRatio) {
		switch ratio {
		case .horizontal:
			constant *= horizontalRatio
		case .vertical:
			constant *= verticalRatio
		}
	}
}
