//
//  Response.swift
//
//
//  Created by Milos Stankovic on 1.7.22..
//  Copyright © 2022 SwiftyLabs. All rights reserved.
//

import Foundation

open class Response: Decodable {
	let message: String?
	let status: Int?
}
