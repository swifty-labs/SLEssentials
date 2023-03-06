//
//  CLLocationCoordinate2D+Equatable.swift
//
//
//  Created by Mirko Licanin on 16.7.21..
//  Copyright © 2021 SwiftyLabs. All rights reserved.
//

import MapKit

extension CLLocationCoordinate2D: Equatable {
	public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
		lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
	}
}
