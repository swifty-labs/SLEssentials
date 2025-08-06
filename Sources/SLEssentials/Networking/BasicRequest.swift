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

	public func imagesResponse(routable: any Routable, images: [UploadImage]?) async throws -> T {
		guard let requestAdapter else {
			return try await createImagesRequest(routable: routable, images: images)
		}
		let newRoutable = try await requestAdapter.adapt(routable)
		return try await createImagesRequest(routable: newRoutable, images: images)
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
					let object = try JSONDecoder().decode(T.self, from: data)
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

		guard let result = (T.self == Data.self) ? (data as? T) : try? JSONDecoder().decode(T.self, from: data) else {
			throw NetworkError.decoding(data)
		}

		return result
	}

	private func createImagesRequest(routable: any Routable, images: [UploadImage]?) async throws -> T {
		var request = URLRequest(url: routable.url)
		request.httpMethod = routable.method.rawValue

		let boundary = UUID().uuidString
		var headers = routable.headers ?? [:]
		headers["Content-Type"] = "multipart/form-data; boundary=\(boundary)"
		request.allHTTPHeaderFields = headers

		var body = Data()

		if let images = images {
			for image in images {
				body.append("--\(boundary)\r\n".data(using: .utf8)!)
				body.append("Content-Disposition: form-data; name=\"\(image.formFieldName)\"; filename=\"\(image.fileName)\"\r\n".data(using: .utf8)!)
				body.append("Content-Type: \(image.mimeType)\r\n\r\n".data(using: .utf8)!)
				body.append(image.data)
				body.append("\r\n".data(using: .utf8)!)
			}
		}

		body.append("--\(boundary)--\r\n".data(using: .utf8)!)
		request.httpBody = body

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

		guard let result = (T.self == Data.self) ? (data as? T) : try? JSONDecoder().decode(T.self, from: data) else {
			throw NetworkError.decoding(data)
		}

		return result
	}
}
