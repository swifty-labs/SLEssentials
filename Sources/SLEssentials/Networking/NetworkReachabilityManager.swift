//
//  NetworkReachabilityManager.swift
//  SLEssentials
//
//  Created by Slobodan Ristic on 5. 5. 2025..
//

import Reachability

public protocol NetworkReachability: AnyObject {
	var isReachable: Bool { get }
}

public final class NetworkReachabilityManager: NetworkReachability {
	public static let shared = NetworkReachabilityManager()
	public var isReachable: Bool {
		(try? Reachability())?.connection != .unavailable
	}
}
