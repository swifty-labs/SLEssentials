//
//  Request.swift
//  Networking
//
//  Created by Milos Stankovic on 18.7.22..
//

import Foundation
import Alamofire

final class Request<T: Routable> {
	// MARK: - Properties
	
	var request: DataRequest? {
		let headers = HTTPHeaders(routable.headers?.map { HTTPHeader(name: $0.name, value: $0.value) } ?? [])
		let method = HTTPMethod(rawValue: routable.method.rawValue)
		var encodingType: ParameterEncoding
		switch routable.encoding {
		case .url:
			encodingType = URLEncoding.default
		case .json:
			encodingType = JSONEncoding.default
		}
		guard let url = routable.url else { return nil }
		return session.request(url, method: method, parameters: routable.parameters, encoding: encodingType, headers: headers)
	}
	private var routable: T
	private var session: Session {
		Session.default
	}

	// MARK: - Initialization
	
	init(routable: T) {
		self.routable = routable
	}
}
