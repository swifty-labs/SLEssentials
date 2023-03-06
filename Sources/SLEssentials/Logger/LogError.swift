//
//  LogError.swift
//
//
//  Created by Milos Stankovic on 20.7.22..
//  Copyright © 2022 SwiftyLabs. All rights reserved.
//

import Foundation

enum LogError: Error {
	case `default`
	case descError(String)
}

extension LogError: LocalizedError {
	public var errorDescription: String? {
		switch self {
		case .default:
			return "Something went wrong"
		case .descError(let message):
			return message
		}
	}
}
