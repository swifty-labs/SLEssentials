//
//  BEError.swift
//  Networking
//
//  Created by Milos Stankovic on 1.7.22..
//

import Foundation

struct BEError {
	let statusCode: Int
	let message: String?

	init(statusCode: Int, message: String?) {
		self.statusCode = statusCode
		self.message = message
	}
}
