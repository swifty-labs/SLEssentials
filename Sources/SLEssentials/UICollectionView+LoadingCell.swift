//
//  UICollectionView+LoadingCell.swift
//
//  Created by Milos Stankovic on 17.6.22..
//  Copyright © 2022 SwiftyLabs. All rights reserved.
//

import UIKit

extension UICollectionView {

    public func registerClass<T: UICollectionViewCell>(_: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }

    public func registerNib<T: UICollectionViewCell>(_: T.Type) {
        register(T.nib, forCellWithReuseIdentifier: T.reuseIdentifier)
    }

    public func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Dequeing a cell with identifier: \(T.reuseIdentifier) failed.")
        }
        return cell
    }
}
