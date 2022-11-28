//
//  Routable.swift
//  Networking
//
//  Created by Milos Stankovic on 14.7.22..
//

import Foundation

public protocol Routable {
	associatedtype T: Decodable
	public var path: String { get }
	public var url: URL? { get }
	public var method: HttpMethod { get }
	public var encoding: ParamsEncoding { get }
	public var headers: [HttpHeader]? { get }
	public var parameters: Parameters? { get }
	public var queryItems: [URLQueryItem]? { get }
}
