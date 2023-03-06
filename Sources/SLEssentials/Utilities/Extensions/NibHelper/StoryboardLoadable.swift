//
//  StoryboardLoadable.swift
//
//
//  Created by Milos Stankovic on 17.6.22..
//  Copyright © 2022 SwiftyLabs. All rights reserved.
//

import UIKit

public protocol StoryboardLoadable {
    static var storyboardName: String { get }
    static var storyboardIdentifier: String { get }
}

extension StoryboardLoadable where Self: UIViewController {
    
    public static var storyboardName: String {
        String(describing: self)
    }
    
    public static var storyboardIdentifier: String {
        String(describing: self)
    }
    
    public static func instantiate(fromStoryboardNamed name: String? = nil) -> Self {
        let sb = name ?? storyboardName
        let storyboard = UIStoryboard(name: sb, bundle: nil)
        return instantiate(fromStoryboard: storyboard)
    }
    
    public static func instantiate(fromStoryboard storyboard: UIStoryboard) -> Self {
        let identifier = storyboardIdentifier
        guard let vc = storyboard.instantiateViewController(withIdentifier: identifier) as? Self else {
            fatalError("Failed to instantiate view controller with identifier=\(identifier) from storyboard \( storyboard )")
        }
        return vc
    }
    
    public static func initial(fromStoryboardNamed name: String? = nil) -> Self {
        let sb = name ?? storyboardName
        let storyboard = UIStoryboard(name: sb, bundle: nil)
        return initial(fromStoryboard: storyboard)
    }
    
    public static func initial(fromStoryboard storyboard: UIStoryboard) -> Self {
        guard let vc = storyboard.instantiateInitialViewController() as? Self else {
            fatalError("Failed to instantiate initial view controller from storyboard named \( storyboard )")
        }
        return vc
    }
}

extension UIViewController: StoryboardLoadable {
    public static var storyboardName: String {
        "Main"
    }
}
