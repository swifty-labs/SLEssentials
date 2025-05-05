//
//  RequestAdapter.swift
//  SLEssentials
//
//  Created by Slobodan Ristic on 5. 5. 2025..
//

import Foundation

public protocol RequestAdapter {
	func adapt(_ routable: any Routable, completion: @escaping (Result<any Routable, NetworkError>) -> Void)
	func adapt(_ routable: any Routable) async throws -> any Routable
}
