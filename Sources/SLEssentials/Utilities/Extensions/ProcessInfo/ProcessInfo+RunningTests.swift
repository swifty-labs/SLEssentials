//
//  ProcessInfo+RunningTests.swift
//
//
//  Created by Mirko Licanin on 23.6.20..
//  Copyright © 2020 SwiftyLabs. All rights reserved.
//

import Foundation

public extension ProcessInfo {
	static var isRunningTests: Bool {
		processInfo.environment["XCTestConfigurationFilePath"] != nil
	}
}
