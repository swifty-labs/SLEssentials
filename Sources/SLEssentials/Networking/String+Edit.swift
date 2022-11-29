//
//  String+Edit.swift
//  SLEssentials
//
//  Created by Milos Stankovic on 3.8.22..
//  Copyright © 2022 SwiftyLabs. All rights reserved.
//

import UIKit

public extension String {
	var withoutSpaces: String {
		self.replacingOccurrences(of: " ", with: "")
	}
	
	var isValidUrl: Bool {
		if let url = URL(string: self) {
			return UIApplication.shared.canOpenURL(url)
		}
		return false
	}
}
