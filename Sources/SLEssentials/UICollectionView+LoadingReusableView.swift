//
//  UICollectionView+LoadingReusableView.swift
//
//  Created by Milos Stankovic on 17.6.22..
//  Copyright © 2022 SwiftyLabs. All rights reserved.
//

import UIKit

extension UICollectionView {
    func registerHeaderNib<T: UICollectionReusableView>(_: T.Type) {
        register(T.nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.reuseIdentifier)
    }
    
    func registerFooterNib<T: UICollectionReusableView>(_: T.Type) {
        register(T.nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableHeader<T: UICollectionReusableView>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Dequeing a cell with identifier: \(T.reuseIdentifier) failed.")
        }
        return cell
    }
    
    func dequeueReusableFooter<T: UICollectionReusableView>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Dequeing a cell with identifier: \(T.reuseIdentifier) failed.")
        }
        return cell
    }
}
