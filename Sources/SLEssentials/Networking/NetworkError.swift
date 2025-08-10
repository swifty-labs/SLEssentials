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
