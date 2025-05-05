//
//  NetworkError.swift
//  Alamofire
//
//  Created by Slobodan Ristic on 5. 5. 2025..
//

import Foundation

public enum NetworkError: Error {
	case general
	case noInternet
	case error(Error)
	case backendUnavailable
	case decoding(Data)
}

extension NetworkError: LocalizedError {
	public var errorDescription: String? {
		switch self {
		case .general:
			"Unknown error"
		case .decoding:
			"Decoding error"
		case .error(let error):
			error.localizedDescription
		case .noInternet:
			"No internet connection"
		case .backendUnavailable:
			"Backend unavailable"
		}
	}
}
