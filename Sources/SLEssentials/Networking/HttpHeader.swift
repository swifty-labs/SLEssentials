//
//  HttpHeader.swift
//  Networking
//
//  Created by Milos Stankovic on 15.7.22..
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
