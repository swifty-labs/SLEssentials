//
//  BEError.swift
//
//
//  Created by Milos Stankovic on 1.7.22..
//  Copyright © 2022 SwiftyLabs. All rights reserved.
//

import Foundation

public struct BEError {
	public let statusCode: Int
	public let message: String?

	public init(statusCode: Int, message: String?) {
		self.statusCode = statusCode
		self.message = message
	}
}
