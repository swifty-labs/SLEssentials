//
//  DataRequest+Response.swift
//  Networking
//
//  Created by Milos Stankovic on 1.7.22..
//

import Foundation
import Alamofire

extension DataRequest {
	func responseObject<T: Decodable>(completion: @escaping (Result<T, NetworkError>) -> ()) {
		responseDecodable(completionHandler: { [weak self] response in
			guard let self else { return }
			completion(self.responseObject(from: response))
		})
	}
	
	func responseArray<T: Decodable>(completion: @escaping (Result<[T], NetworkError>) -> ()) {
		responseDecodable(completionHandler: { [weak self] response in
			guard let self else { return }
			completion(self.responseArray(from: response))
		})
	}
	
	func responseString(completion: @escaping (Result<String, NetworkError>) -> ()) {
		responseString(completionHandler: {[weak self] response in
			guard let self else { return }
			completion(self.responseString(from: response))
		})
	}
	
	// MARK: - Private Methods
	
	private func responseObject<T: Decodable>(from responseData: AFDataResponse<T>) -> Result<T, NetworkError> {
		guard NetworkReachabilityManager()?.isReachable ?? false else {
			return .failure(.noInternet)
		}
		guard case .success = responseData.result else {
			return .failure(error(from: responseData))
		}
		return decode(response: responseData)
	}
	
	private func responseArray<T: Decodable>(from responseData: AFDataResponse<[T]>) -> Result<[T], NetworkError> {
		guard NetworkReachabilityManager()?.isReachable ?? false else {
			return .failure(.noInternet)
		}
		guard case .success = responseData.result else {
			return .failure(error(from: responseData))
		}
		return  decode(response: responseData)
	}
	
	private func responseString(from responseData: AFDataResponse<String>) -> Result<String, NetworkError> {
		guard NetworkReachabilityManager()?.isReachable ?? false else {
			return .failure(NetworkError.noInternet)
		}
		guard case .success(let string) = responseData.result else {
			return .failure(NetworkError.mapping)
		}
		return .success(string)
	}
	
	private func error<T:Decodable>(from responseData: AFDataResponse<T>) -> NetworkError {
		guard let statusCode = responseData.response?.statusCode else {
			return NetworkError.general
		}
		guard let data = responseData.data, let response: Response = decode(data: data) else {
			return NetworkError.mapping
		}
		let error = BEError(statusCode: statusCode, message: response.message?.description )
		return NetworkError.backend(error)
	}
	
	private func decode<T: Decodable>(response: AFDataResponse<T>) -> Result<T, NetworkError> {
		guard let data = response.data, let statusCode = response.response?.statusCode else {
			return .failure(.general)
		}
		switch response.result {
		case .success:
			guard let result: T = decode(data: data) else {
				return .failure(.mapping)
			}
			return .success(result)
		case .failure:
			return .failure(.backend(.init(statusCode: statusCode, message: response.error?.errorDescription)))
		}
	}
	
	private func decode<T: Decodable>(data: Data) -> T? {
		let decoder = JSONDecoder()
		return try? decoder.decode(T.self, from: data)
	}
}
