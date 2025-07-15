//
//  BasicRequest.swift
//  Pods
//
//  Created by Slobodan Ristic on 5. 5. 2025..
//

import Foundation

public final class BasicRequest<T: Decodable>: Request {
	// MARK: - Properties

	public var networkReachability: (any NetworkReachability)?
	public var requestAdapter: RequestAdapter?

	// MARK: - Public methods

	public func response(routable: any Routable, completion: @escaping VoidReturnClosure<Result<T, NetworkError>>) {
		guard let requestAdapter else {
			createRequest(routable: routable, completion: completion)
			return
		}
		requestAdapter.adapt(routable) { result in
			switch result {
			case .success(let newRoutable):
				self.createRequest(routable: newRoutable, completion: completion)
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}

	public func response(routable: any Routable) async throws -> T {
		guard let requestAdapter else {
			return try await createRequest(routable: routable)
		}
		let newRoutable = try await requestAdapter.adapt(routable)
		return try await createRequest(routable: newRoutable)
	}

	// MARK: - Private methods

	private func createRequest(routable: any Routable, completion: @escaping VoidReturnClosure<Result<T, NetworkError>>) {
		var request = URLRequest(url: routable.url)
		request.httpMethod = routable.method.rawValue

		var headers = routable.headers ?? [:]
		headers.merge(routable.encoding.contentType)
		request.allHTTPHeaderFields = headers

		if routable.encoding == .json, let params = routable.parameters {
			request.httpBody = try? JSONEncoder().encode(params)
		}

		URLSession.shared.dataTask(with: request) { data, response, error in
			DispatchQueue.main.async {
				if let networkReachability = self.networkReachability, !networkReachability.isReachable  {
					completion(.failure(.noInternet))
					return
				}
				if let error = error as? URLError, error.code == .timedOut {
					completion(.failure(.backendUnavailable))
					return
				}
				if let error {
					completion(.failure(.error(error)))
					return
				}
				guard let httpResponse = response as? HTTPURLResponse, 200...300 ~= httpResponse.statusCode else {
					completion(.failure(.general))
					return
				}
				guard let data else {
					completion(.failure(.general))
					return
				}
				do {
					let decoder = JSONDecoder()
					decoder.keyDecodingStrategy = .convertFromSnakeCase
					decoder.dateDecodingStrategy = .custom { decoder in
						let container = try decoder.singleValueContainer()
						let dateString = try container.decode(String.self)
						return DateFormat.defaultFormat.date(from: dateString) ?? Date()
					}
					let object = try decoder.decode(T.self, from: data)
					completion(.success(object))
				} catch {
					completion(.failure(.decoding(data)))
				}
			}
		}
		.resume()
	}

	private func createRequest(routable: any Routable) async throws -> T {
		var request = URLRequest(url: routable.url)
		request.httpMethod = routable.method.rawValue

		var headers = routable.headers ?? [:]
		headers.merge(routable.encoding.contentType)
		request.allHTTPHeaderFields = headers

		if routable.encoding == .json, let params = routable.parameters {
			request.httpBody = try? JSONEncoder().encode(params)
		}

		let (data, response) = try await URLSession.shared.data(for: request)

		guard let networkReachability = self.networkReachability else {
			throw NetworkError.noInternet
		}
		guard networkReachability.isReachable else {
			throw NetworkError.noInternet
		}
		guard let httpResponse = response as? HTTPURLResponse, 200...300 ~= httpResponse.statusCode else {
			throw NetworkError.general
		}

		let decoder = JSONDecoder()
		decoder.keyDecodingStrategy = .convertFromSnakeCase
		decoder.dateDecodingStrategy = .custom { decoder in
			let container = try decoder.singleValueContainer()
			let dateString = try container.decode(String.self)
			return DateFormat.defaultFormat.date(from: dateString) ?? Date()
		}

		guard let result = (T.self == Data.self) ? (data as? T) : try? decoder.decode(T.self, from: data) else {
			throw NetworkError.decoding(data)
		}

		return result
	}
}
