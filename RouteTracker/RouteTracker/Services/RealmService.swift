//
//  RealmService.swift
//  RouteTracker
//
//  Created by Елена Русских on 2024-01-11.
//

import Foundation
import RealmSwift
import GoogleMaps

// MARK: - RealmService
final class RealmService {
    private var realm: Realm? {
        do {
            return try Realm()
        } catch {
            print("Realm error: \(error)")
            return nil
        }
    }

    // MARK: Save Route
    func saveRoute(_ routePath: GMSMutablePath) {
        guard let realm = realm else { return }
        do {
            try realm.write {
                let allRoutePoints = realm.objects(RoutePoint.self)
                realm.delete(allRoutePoints)
                
                for index in 0..<routePath.count() {
                    let coordinate = routePath.coordinate(at: index)
                    let routePoint = RoutePoint()
                    routePoint.latitude = coordinate.latitude
                    routePoint.longitude = coordinate.longitude
                    realm.add(routePoint)
                }
            }
        } catch {
            print("Save route error: \(error)")
        }
    }

    // MARK: Load Route
    func loadRoute() -> GMSMutablePath? {
        guard let realm = realm else { return nil }
        let savedRoutePoints = realm.objects(RoutePoint.self)
        if savedRoutePoints.isEmpty {
            return nil
        }
        
        let path = GMSMutablePath()
        savedRoutePoints.forEach { routePoint in
            path.add(CLLocationCoordinate2D(latitude: routePoint.latitude, longitude: routePoint.longitude))
        }
        return path
    }

    // MARK: Delete All Route Points
    func deleteAllRoutePoints() {
        guard let realm = realm else { return }
        do {
            try realm.write {
                let allRoutePoints = realm.objects(RoutePoint.self)
                realm.delete(allRoutePoints)
            }
        } catch {
            print("Delete all route points error: \(error)")
        }
    }
}
