//
//  LinkedList.swift
//
//
//  Created by Mirko Licanin on 2.3.20..
//  Copyright © 2020 SwiftyLabs. All rights reserved.
//

public class LinkedList<T> {
	public var isEmpty: Bool { head == nil }
	public var first: Node<T>? { head }
	public var last: Node<T>? { tail }
	
	private var head: Node<T>?
	private var tail: Node<T>?
	
	// MARK: - Initialization
	
	public init() {}
	
	public init(values: [T]) {
		values.forEach { append(value: $0) }
	}
	
	// MARK: - Public methods
	
	public func append(value: T) {
		let newNode = Node(value: value)
		if let tailNode = tail {
			newNode.previous = tailNode
			tailNode.next = newNode
		} else {
			head = newNode
		}
		tail = newNode
	}
}
