//
//  ErrorInterceptor.swift
//  SLEssentials
//
//  Created by Slobodan Ristic on 5. 5. 2025..
//

import Foundation

public protocol ErrorInterceptor: AnyObject {
	func handle<Service: Routable>(error: NetworkError, service: Service)
}
