//
//  String+Edit.swift
//
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
		guard let url = URL(string: self) else { return false }
		return UIApplication.shared.canOpenURL(url)
	}
}
