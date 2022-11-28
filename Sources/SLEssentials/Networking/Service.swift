//
//  Service.swift
//  Networking
//
//  Created by Milos Stankovic on 1.7.22..
//

import Foundation
import Combine

typealias VoidReturnClosure<T> = (T) -> ()
public typealias Parameters = [String: Any]

open class Service<T: Decodable> {
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
	
	@available(iOS 13.0.0, *)
	public var consumeObject: T? {
		get async throws {
			try await requestObject.request?.serializingDecodable(T.self).value
		}
	}
	
	@available(iOS 13.0.0, *)
	public var consumeArray: [T]? {
		get async throws {
			try await requestObject.request?.serializingDecodable([T].self).value
		}
	}
	
	@available(iOS 13.0.0, *)
	public var consumeString: String? {
		get async throws {
			try await requestObject.request?.serializingString().value
		}
	}
	
	@available(iOS 13.0.0, *)
	public var object: AnyPublisher<T, NetworkError>? {
		requestObject.request?.publishDecodable(type: T.self)
			.value()
			.mapError { NetworkError.alamofire($0) }
			.eraseToAnyPublisher()
	}
	
	@available(iOS 13.0.0, *)
	public var array: AnyPublisher<[T], NetworkError>? {
		requestObject.request?.publishDecodable(type: [T].self)
			.value()
			.mapError { NetworkError.alamofire($0) }
			.eraseToAnyPublisher()
	}
	
	@available(iOS 13.0.0, *)
	public var string: AnyPublisher<String, NetworkError>? {
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
	
	public func consumeObject(completion: VoidReturnClosure<Result<T, NetworkError>>?) {
		guard let completion = completion else { return }
		requestObject.request?.validate().responseObject(completion: completion)
	}
	
	public func consumeArray(completion: VoidReturnClosure<Result<[T], NetworkError>>?) {
		guard let completion = completion else { return }
		requestObject.request?.validate().responseArray(completion: completion)
	}
	
	public func consumeString(completion: VoidReturnClosure<Result<String, NetworkError>>?) {
		guard let completion = completion else { return }
		requestObject.request?.validate().responseString(completion: completion)
	}
}

// MARK: - Routable

public extension Service: Routable {
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
