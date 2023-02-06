//
//  UITableView+LoadingHeaderFooter.swift
//
//
//  Created by Milos Stankovic on 17.6.22..
//  Copyright © 2022 SwiftyLabs. All rights reserved.
//

import UIKit

extension UITableView {
    func registerHeaderFooterNib<T: UITableViewHeaderFooterView>(_ uiView: T.Type) {
        register(uiView, forHeaderFooterViewReuseIdentifier: T.description())
    }
    
    func dequeueReusableHeaderFooter<T: UITableViewHeaderFooterView>() -> T {
        guard let cell = dequeueReusableHeaderFooterView(withIdentifier: T.description()) as? T else {
            fatalError("Dequeing a cell with identifier: \(T.description()) failed.")
        }
        return cell
    }
}
