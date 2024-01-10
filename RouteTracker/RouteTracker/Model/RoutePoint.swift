//
//  RoutePoint.swift
//  RouteTracker
//
//  Created by Елена Русских on 2024-01-10.
//

import Foundation
import RealmSwift

class RoutePoint: Object {
    @objc dynamic var latitude: Double = 0.0
    @objc dynamic var longitude: Double = 0.0
    @objc dynamic var timestamp: Date = Date()
    
    convenience init(latitude: Double, longitude: Double) {
        self.init()
        self.latitude = latitude
        self.longitude = longitude
    }
}

