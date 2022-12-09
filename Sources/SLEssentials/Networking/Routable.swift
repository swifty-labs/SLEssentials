//
//  Routable.swift
//  SLEssentials
//
//  Created by Milos Stankovic on 14.7.22..
//  Copyright © 2022 SwiftyLabs. All rights reserved.
//

import Foundation

public protocol Routable {
	associatedtype T: Decodable
	var path: String { get }
	var url: URL { get }
	var method: HttpMethod { get }
	var encoding: ParamsEncoding { get }
	var headers: [HttpHeader]? { get }
	var parameters: Parameters? { get }
	var queryItems: [URLQueryItem]? { get }
}
