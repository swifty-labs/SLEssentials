//
//  Serviceable.swift
//  SLEssentials
//
//  Created by Milos Stankovic on 22.11.22..
//  Copyright © 2022 SwiftyLabs. All rights reserved.
//

import Foundation

public struct Serviceable {
	var scheme: Scheme = .secure
	var baseUrl: String
	var urlPath: String
	var httpMethod: HttpMethod = .get
	var paramEncoding: ParamsEncoding = .url
	var httpHeaders: [HttpHeader]? = nil
	var params: Parameters? = nil
	var items: [URLQueryItem]? = nil
}
