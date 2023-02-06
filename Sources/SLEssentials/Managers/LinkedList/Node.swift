//
//  Node.swift
//
//
//  Created by Mirko Licanin on 2.3.20..
//  Copyright © 2020 SwiftyLabs. All rights reserved.
//

public class Node<T> {
	public var value: T
	public var next: Node?
	public weak var previous: Node?
	
	public init(value: T) {
		self.value = value
	}
}
