//
//  String+Edit.swift
//  Networking
//
//  Created by Milos Stankovic on 3.8.22..
//

import UIKit

extension String {
	public var withoutSpaces: String {
		self.replacingOccurrences(of: " ", with: "")
	}
	
	public var isValidUrl: Bool {
		if let url = URL(string: self) {
			return UIApplication.shared.canOpenURL(url)
		}
		return false
	}
}
