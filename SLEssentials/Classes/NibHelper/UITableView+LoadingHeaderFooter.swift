//
//  UITableView+LoadingHeaderFooter.swift
//  SLEssentials
//
//  Created by Vukasin Popovic on 16.12.21..
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
