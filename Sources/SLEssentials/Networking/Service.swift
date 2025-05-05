//
//  Service.swift
//  SLEssentials
//
//  Created by Slobodan Ristic on 5. 5. 2025..
//

import Foundation

public final class Service<T: Decodable>: Routable {
	// MARK: - Properties

	public let scheme: Scheme
	public let baseUrl: String
	public let urlPath: String
	public let method: HTTPMethod
	public let encoding: ParametersEncoding
	public let parameters: Parameters?
	public let queryItems: [URLQueryItem]?
	public var headers: HTTPHeaders?
	public var errorInterceptor: ErrorInterceptor?
	public var networkReachability: NetworkReachability?
	public var requestAdapter: RequestAdapter?
	public var completion: VoidReturnClosure<Result<T, NetworkError>>?

	private let request = BasicRequest<T>()

	// MARK: - Initialization

	public init(scheme: Scheme = .https,
		 baseUrl: String,
		 urlPath: String,
		 method: HTTPMethod = .get,
		 encoding: ParametersEncoding = .url,
		 headers: HTTPHeaders? = [:],
		 parameters: Parameters? = nil,
		 queryItems: [URLQueryItem]? = nil) {
		self.scheme = scheme
		self.baseUrl = baseUrl
		self.urlPath = urlPath
		self.method = method
		self.encoding = encoding
		self.headers = headers
		self.parameters = parameters
		self.queryItems = queryItems
	}

	// MARK: - Deinit

	deinit {
		Logger.logDeinit()
	}

	// MARK: - Public methods

	public func consume(completion: VoidReturnClosure<Result<T, NetworkError>>?) {
		self.completion = completion
		request.networkReachability = networkReachability
		request.requestAdapter = requestAdapter
		request.response(routable: self) { result in
			switch result {
			case .success(let object):
				completion?(.success(object))
			case .failure(let error):
				if let errorInterceptor = self.errorInterceptor {
					errorInterceptor.handle(error: error, service: self)
				}
				else {
					completion?(.failure(error))
				}
			}
		}
	}

	public func consume() async throws -> T {
		request.networkReachability = networkReachability
		request.requestAdapter = requestAdapter
		return try await request.response(routable: self)
	}

	public func retry() {
		consume(completion: completion)
	}

	public func retry() async throws -> T {
		try await consume()
	}
}
