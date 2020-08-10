//
//  NibReusable.swift
//  SLEssentials
//
//  Created by Mirko on 1/3/18.
//  Copyright © 2018 SwiftyLabs. All rights reserved.
//

import UIKit

protocol NibReusable: Reusable, NibLoadable {
}

extension UITableViewCell: NibReusable {
}

extension UICollectionViewCell: NibReusable {
}
