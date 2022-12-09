//
//  Service.swift
//  SLEssentials
//
//  Created by Milos Stankovic on 1.7.22..
//  Copyright © 2022 SwiftyLabs. All rights reserved.
//

import Foundation
import Combine

open class Service<T: Decodable> {
	// MARK: - Properties
	
	private lazy var requestObject = Request(routable: self)
	
	private var serviceable: Serviceable
	private var urlAddress: URL!
	private var createUrl: URL {
		var components = URLComponents()
		components.scheme = serviceable.scheme.rawValue
		components.host = serviceable.baseUrl
		components.path = path
		components.queryItems = queryItems
		guard let url = components.url else {
			fatalError("Invalid url: \(serviceable.scheme.rawValue)\(serviceable.baseUrl)\(serviceable.urlPath)")
		}
		return url
	}
	
	@available(iOS 13.0.0, *)
	open var consumeObject: T {
		get async throws {
			try await requestObject.request.serializingDecodable(T.self).value
		}
	}
	
	@available(iOS 13.0.0, *)
	open var consumeArray: [T] {
		get async throws {
			try await requestObject.request.serializingDecodable([T].self).value
		}
	}
	
	@available(iOS 13.0.0, *)
	open var consumeString: String {
		get async throws {
			try await requestObject.request.serializingString().value
		}
	}
	
	@available(iOS 13.0.0, *)
	open var object: AnyPublisher<T, NetworkError> {
		requestObject.request.publishDecodable(type: T.self)
			.value()
			.mapError { NetworkError.alamofire($0) }
			.eraseToAnyPublisher()
	}
	
	@available(iOS 13.0.0, *)
	open var array: AnyPublisher<[T], NetworkError> {
		requestObject.request.publishDecodable(type: [T].self)
			.value()
			.mapError { NetworkError.alamofire($0) }
			.eraseToAnyPublisher()
	}
	
	@available(iOS 13.0.0, *)
	open var string: AnyPublisher<String, NetworkError> {
		requestObject.request.publishString()
			.value()
			.mapError { NetworkError.alamofire($0) }
			.eraseToAnyPublisher()
	}
	
	// MARK: - Initialization
	
	public init(serviceable: Serviceable) {
		self.serviceable = serviceable
		self.urlAddress = self.createUrl
	}
	
	public init?(urlString: String) {
		guard let url = URL(string: urlString.withoutSpaces) else { return nil }
		serviceable = Serviceable(baseUrl: "", urlPath: "")
		urlAddress = url
	}
	
	// MARK: - Public methods
	
	open func consumeObject(completion: @escaping VoidReturnClosure<Result<T, NetworkError>>) {
		requestObject.request.validate().responseObject(completion: completion)
	}
	
	open func consumeArray(completion: @escaping VoidReturnClosure<Result<[T], NetworkError>>) {
		requestObject.request.validate().responseArray(completion: completion)
	}
	
	open func consumeString(completion: @escaping VoidReturnClosure<Result<String, NetworkError>>) {
		requestObject.request.validate().responseString(completion: completion)
	}
}

// MARK: - Routable

extension Service: Routable {
	public var path: String {
		serviceable.urlPath
	}
	
	public var url: URL {
		urlAddress
	}
	
	public var method: HttpMethod {
		serviceable.httpMethod
	}
	
	public var encoding: ParamsEncoding {
		serviceable.paramEncoding
	}
	
	public var headers: [HttpHeader]? {
		serviceable.httpHeaders
	}
	
	public var parameters: Parameters? {
		serviceable.params
	}
	
	public var queryItems: [URLQueryItem]? {
		serviceable.items
	}
}
