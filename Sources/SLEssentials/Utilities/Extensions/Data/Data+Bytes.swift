//
//  Data+Bytes.swift
//
//
//  Created by Mirko Licanin on 11.25.19..
//  Copyright © 2019 SwiftyLabs. All rights reserved.
//

import Foundation

public extension Data {
	var toBytes: [UInt8] {
		[UInt8](self)
	}
}
