//
//  HttpHeader.swift
//  SLEssentials
//
//  Created by Milos Stankovic on 15.7.22..
//  Copyright © 2022 SwiftyLabs. All rights reserved.
//

import Foundation

public struct HttpHeader {
	public let name: String
	public let value: String

	public init(name: String, value: String) {
		self.name = name
		self.value = value
	}
}
