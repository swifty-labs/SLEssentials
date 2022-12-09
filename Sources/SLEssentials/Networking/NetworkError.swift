//
//  NetworkError.swift
//  SLEssentials
//
//  Created by Milos Stankovic on 1.7.22..
//  Copyright © 2022 SwiftyLabs. All rights reserved.
//

import Foundation

public enum NetworkError {
	case general
	case alamofire(Error)
	case mapping
	case backend(BEError)
	case noInternet
	case badUrl
}

extension NetworkError: LocalizedError {
	public var errorDescription: String? {
		switch self {
		case .general, .mapping, .alamofire:
			return "Something has gone wrong!"
		case .backend(let error):
			return error.message
		case .noInternet:
			return "No Internet Connection!"
		case .badUrl:
			return "Bad url address!"
		}
	}
}
