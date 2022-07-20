//
//  Logger.swift
//  SLEssentials
//
//  Created by Milos Stankovic on 20.7.22..
//  Copyright © 2022 SwiftyLabs. All rights reserved.
//

import Foundation

enum LogEvent: String {
	case debug = "🐛"
	case error = "❌"
	case `deinit` = "💨"
}

enum LogType {
	case date, featureName(String), fileName, methodName, lineNumber
}

struct Logger {
	// MARK: - Properties

	private var logTypes: [LogType]

	// MARK: - Initializaion

	init(logTypes: [LogType] = [.date, .fileName, .methodName, .lineNumber]) {
		self.logTypes = logTypes
	}

	// MARK: - Static methods

	static func logDeinit(filePath: String = #file) {
		print("\(LogEvent.deinit.rawValue) DEINIT: \(fileName(fromFilePath: filePath))")
	}

	private static func fileName(fromFilePath filePath: String) -> String {
		let components = filePath.components(separatedBy: "/")
		return components.isEmpty ? "" : components.last ?? ""
	}

	// MARK: - Public methods

	func log(filePath: String = #file, methodName: String = #function, lineNumber: Int = #line, message: String? = nil, error: Error? = nil) {
		var output = ""
		output += error == nil ? LogEvent.debug.rawValue : LogEvent.error.rawValue
		for type in logTypes {
			output += " "
			switch type {
			case .date:
				output += Date().toString
			case .featureName(let featureName):
				output += featureName
			case .fileName:
				output += Logger.fileName(fromFilePath: filePath)
			case .methodName:
				output += methodName
			case .lineNumber:
				output += String(lineNumber)
			}
		}
		if let message = message {
			output += " \(message)"
		}
		if let errorMessage = error?.localizedDescription {
			output += " \(errorMessage)"
		}
		print(output)
	}
}
