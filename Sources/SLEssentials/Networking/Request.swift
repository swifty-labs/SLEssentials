//
//  Request.swift
//  SLEssentials
//
//  Created by Slobodan Ristic on 5. 5. 2025..
//

import Foundation

public protocol Request {
	associatedtype T: Decodable

	func response(routable: any Routable, completion: @escaping VoidReturnClosure<Result<T, NetworkError>>)
	func response(routable: any Routable) async throws -> T
}
