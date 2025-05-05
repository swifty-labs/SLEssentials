//
//  DateFormat.swift
//  SLEssentials
//
//  Created by Slobodan Ristic on 5. 5. 2025..
//

import Foundation

public enum DateFormat: String {
	case defaultFormat = "yyyy-MM-dd HH:mm:ss"
	case date = "yyyy/MM/dd"
	case dateCondensed = "yyyyMMdd"
	case dateTimeTimeZone = "yyyyMMddHHmmss XXXXX"
	case time = "HH:mm"

	// MARK: - Properties

	private static let systemFormatter = DateFormatter()

	private var formatter: DateFormatter {
		DateFormat.systemFormatter.dateFormat = self.rawValue
		return DateFormat.systemFormatter
	}

	// MARK: - Public methods

	public func string(from date: Date) -> String? {
		formatter.string(from: date)
	}

	public func date(from string: String) -> Date? {
		formatter.date(from: string)
	}

	public func timestampSeconds(for date: Date) -> Int {
		Int(date.timeIntervalSince1970)
	}
}
