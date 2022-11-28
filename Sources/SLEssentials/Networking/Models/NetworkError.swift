//
//  NetworkError.swift
//  Networking
//
//  Created by Milos Stankovic on 1.7.22..
//

import Foundation

enum NetworkError {
	case general
	case alamofire(Error)
	case mapping
	case backend(BEError)
	case noInternet
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
		}
	}
}
