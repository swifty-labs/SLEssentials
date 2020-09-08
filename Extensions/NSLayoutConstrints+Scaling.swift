//
//  NSLayoutConstrints+Scaling.swift
//  SLEssentials
//
//  Created by Vukasin on 08/09/2020.
//

import Foundation

public enum AxialRatio {
	case vertical, horizontal
}

extension NSLayoutConstraint {
	var horizontalRatio: CGFloat {
		return UIScreen.main.bounds.width / 414.0
	}
	var verticalRatio: CGFloat {
		return UIScreen.main.bounds.height / 896.0
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
