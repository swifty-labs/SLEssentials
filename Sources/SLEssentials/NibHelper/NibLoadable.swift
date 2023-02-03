//
//  NibLoadable.swift
//
//  Created by Milos Stankovic on 17.6.22..
//  Copyright © 2022 SwiftyLabs. All rights reserved.
//

import UIKit

public protocol NibLoadable {
    static var nibName: String { get }
    static var nib: UINib { get }
}

extension NibLoadable where Self: UIView {
	public static var nibName: String {
        String(describing: self)
    }
    
	public static var nib: UINib {
        UINib(nibName: nibName, bundle: Bundle(for: self))
    }
}
