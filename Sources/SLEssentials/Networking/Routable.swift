//
//  Routable.swift
//  SLEssentials
//
//  Created by Slobodan Ristic on 5. 5. 2025..
//

import Foundation

public protocol Routable {
	associatedtype Response: Decodable

	var scheme: Scheme { get }
	var baseUrl: String { get }
	var urlPath: String { get }
	var method: HTTPMethod { get }
	var encoding: ParametersEncoding { get }
	var headers: HTTPHeaders? { get set }
	var parameters: Parameters? { get }
	var queryItems: [URLQueryItem]? { get }
	var completion: VoidReturnClosure<Result<Response, NetworkError>>? { get set }

	func consume(completion: VoidReturnClosure<Result<Response, NetworkError>>?)
	func retry()
}

extension Routable {
	var url: URL {
		var components = URLComponents()
		components.scheme = scheme.rawValue
		components.host = baseUrl
		components.path = urlPath
		components.queryItems = queryItems
		if encoding == .url {
			components.queryItems = parameters?.queryItems
		}
		guard let url = components.url else {
			fatalError("Invalid url: \(scheme.rawValue)\(baseUrl)\(urlPath)")
		}
		return url
	}
}

public enum Scheme: String {
	case https, http
}

public enum HTTPMethod: String {
	case get = "GET"
	case post = "POST"
	case put = "PUT"
	case patch = "PATCH"
	case delete = "DELETE"
	case head = "HEAD"
}

public enum ParametersEncoding {
	case json, url

	var contentType: [String: String] {
		switch self {
		case .json:
			["Content-Type": "application/json"]
		case .url:
			["Content-Type": "application/x-www-form-urlencoded"]
		}
	}
}
