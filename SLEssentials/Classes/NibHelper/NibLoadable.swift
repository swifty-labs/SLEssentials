//
//  NibLoadable.swift
//  SLEssentials
//
//  Created by Mirko on 1/3/18.
//  Copyright © 2018 SwiftyLabs. All rights reserved.
//

import UIKit

public protocol NibLoadable {
    static var nibName: String { get }
    static var nib: UINib { get }
}

extension NibLoadable where Self: UIView {
	public static var nibName: String {
        return String(describing: self)
    }
    
	public     static var nib: UINib {
        return UINib(nibName: nibName, bundle: Bundle(for: self))
    }
}
