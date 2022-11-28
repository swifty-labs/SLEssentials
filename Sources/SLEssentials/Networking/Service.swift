//
//  Service.swift
//  Networking
//
//  Created by Milos Stankovic on 1.7.22..
//

import Foundation
import Combine

typealias Parameters = [String: Any]
typealias VoidReturnClosure<T> = (T) -> ()

public class Service<T: Decodable> {
	// MARK: - Properties
	
	private lazy var requestObject = Request(routable: self)
	
	private var serviceable: Serviceable
	private var urlAddress: URL?
	private var createUrl: URL? {
		var components = URLComponents()
		components.scheme = serviceable.scheme.rawValue
		components.host = serviceable.baseUrl
		components.path = path
		components.queryItems = queryItems
		guard let url = components.url else { return nil }
		return url
	}
	
	var consumeObject: T? {
		get async throws {
			try await requestObject.request?.serializingDecodable(T.self).value
		}
	}
	
	var consumeArray: [T]? {
		get async throws {
			try await requestObject.request?.serializingDecodable([T].self).value
		}
	}
	
	var consumeString: String? {
		get async throws {
			try await requestObject.request?.serializingString().value
		}
	}
	
	var object: AnyPublisher<T, NetworkError>? {
		requestObject.request?.publishDecodable(type: T.self)
			.value()
			.mapError { NetworkError.alamofire($0) }
			.eraseToAnyPublisher()
	}
	
	var array: AnyPublisher<[T], NetworkError>? {
		requestObject.request?.publishDecodable(type: [T].self)
			.value()
			.mapError { NetworkError.alamofire($0) }
			.eraseToAnyPublisher()
	}
	
	var string: AnyPublisher<String, NetworkError>? {
		requestObject.request?.publishString()
			.value()
			.mapError { NetworkError.alamofire($0) }
			.eraseToAnyPublisher()
	}
	
	// MARK: - Initialization
	
	init(serviceable: Serviceable) {
		self.serviceable = serviceable
		self.urlAddress = createUrl
	}
	
	init?(urlString: String) {
		guard let url = URL(string: urlString.withoutSpaces) else { return nil }
		serviceable = Serviceable(baseUrl: "", urlPath: "")
		urlAddress = url
	}
	
	// MARK: - Public methods
	
	func consumeObject(completion: VoidReturnClosure<Result<T, NetworkError>>?) {
		guard let completion = completion else { return }
		requestObject.request?.validate().responseObject(completion: completion)
	}
	
	func consumeArray(completion: VoidReturnClosure<Result<[T], NetworkError>>?) {
		guard let completion = completion else { return }
		requestObject.request?.validate().responseArray(completion: completion)
	}
	
	func consumeString(completion: VoidReturnClosure<Result<String, NetworkError>>?) {
		guard let completion = completion else { return }
		requestObject.request?.validate().responseString(completion: completion)
	}
}

// MARK: - Routable

extension Service: Routable {
	var path: String {
		serviceable.urlPath
	}
	
	var url: URL? {
		urlAddress
	}
	
	var method: HttpMethod {
		serviceable.httpMethod
	}
	
	var encoding: ParamsEncoding {
		serviceable.paramEncoding
	}
	
	var headers: [HttpHeader]? {
		serviceable.httpHeaders
	}
	
	var parameters: Parameters? {
		serviceable.params
	}
	
	var queryItems: [URLQueryItem]? {
		serviceable.items
	}
}
