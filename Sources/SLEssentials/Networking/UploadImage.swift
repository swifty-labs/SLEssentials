//
//  UploadImage.swift
//  SLEssentials
//
//  Created by Slobodan Ristic on 6. 8. 2025..
//

import Foundation

public struct UploadImage {
	public let data: Data
	public let fileName: String
	public let mimeType: String
	public let formFieldName: String

	public init(data: Data, fileName: String, mimeType: String, formFieldName: String) {
		self.data = data
		self.fileName = fileName
		self.mimeType = mimeType
		self.formFieldName = formFieldName
	}
}
