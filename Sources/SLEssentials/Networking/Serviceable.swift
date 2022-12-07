//
//  Serviceable.swift
//  SLEssentials
//
//  Created by Milos Stankovic on 22.11.22..
//  Copyright © 2022 SwiftyLabs. All rights reserved.
//

import Foundation

public struct Serviceable {
	var scheme: Scheme 
	var baseUrl: String
	var urlPath: String
	var httpMethod: HttpMethod
	var paramEncoding: ParamsEncoding
	var httpHeaders: [HttpHeader]?
	var params: Parameters?
	var items: [URLQueryItem]?
	
	public init(scheme: Scheme = .secure, baseUrl: String, urlPath: String, httpMethod: HttpMethod = .get, paramEncoding: ParamsEncoding = .url, httpHeaders: [HttpHeader]? = nil, params: Parameters? = nil, items: [URLQueryItem]? = nil) {
		self.scheme = scheme
		self.baseUrl = baseUrl
		self.urlPath = urlPath
		self.httpMethod = httpMethod
		self.paramEncoding = paramEncoding
		self.httpHeaders = httpHeaders
		self.params = params
		self.items = items
	}
}
