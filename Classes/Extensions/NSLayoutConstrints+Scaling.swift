//
//  NSLayoutConstrints+Scaling.swift
//  SLEssentials
//
//  Created by Vukasin on 08/09/2020.
//

import Foundation

enum AxialRatio {
	case vertical, horizontal
}

extension NSLayoutConstraint {
	private var horizontalRatio: CGFloat {
		return UIScreen.main.bounds.width / 414.0
	}
	private var verticalRatio: CGFloat {
		return UIScreen.main.bounds.height / 896.0
	}

	func adjust(for ratio: AxialRatio) {
		switch ratio {
		case .horizontal:
			constant *= horizontalRatio
		case .vertical:
			constant *= verticalRatio
		}
	}
}
