//
//  ViewLoadable.swift
//  SLEssentials
//
//  Created by Mirko on 1/3/18.
//  Copyright © 2018 SwiftyLabs. All rights reserved.
//

public protocol ViewLoadable: NibLoadable {
    static var instance: Self { get }
}

extension ViewLoadable {
    public static var instance: Self {
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? Self else {
            fatalError("Failed to create an instance of \(self) from \(self.nibName) nib.")
        }
        return view
    }
}
