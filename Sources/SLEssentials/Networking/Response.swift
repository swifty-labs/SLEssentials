//
//  Response.swift
//  Networking
//
//  Created by Milos Stankovic on 1.7.22..
//

import Foundation

public class Response: Decodable {
	let message: String?
	let status: Int?
}
