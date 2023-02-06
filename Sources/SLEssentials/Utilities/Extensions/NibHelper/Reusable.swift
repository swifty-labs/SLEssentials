//
//  Reusable.swift
//
//
//  Created by Milos Stankovic on 17.6.22..
//  Copyright © 2022 SwiftyLabs. All rights reserved.
//

import UIKit

public protocol Reusable {
    static var reuseIdentifier: String { get }
}

extension Reusable where Self: UIView {
	public static var reuseIdentifier: String {
        String(describing: self)
    }
}
