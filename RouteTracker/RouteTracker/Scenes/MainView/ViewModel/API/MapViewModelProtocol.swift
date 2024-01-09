//
//  MapViewModelProtocol.swift
//  RouteTracker
//
//  Created by Елена Русских on 2024-01-09.
//
import GoogleMaps

// MARK: - MapViewModelProtocol
protocol MapViewModelProtocol: ObservableObject {
    var cameraPosition: GMSCameraPosition { get set }
    var marker: GMSMarker? { get set }
    func moveToDnipro()
    func addMarker(at position: CLLocationCoordinate2D)
}
