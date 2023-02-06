//
//  NibReusable.swift
//
//
//  Created by Milos Stankovic on 17.6.22..
//  Copyright © 2022 SwiftyLabs. All rights reserved.
//

import UIKit

protocol NibReusable: Reusable, NibLoadable {
}

extension UITableViewCell: NibReusable {
}

extension UITableViewHeaderFooterView: NibReusable {
}

extension UICollectionReusableView: NibReusable {
}
