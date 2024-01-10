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
    var markers: [GMSMarker] { get set }
    var route: GMSPolyline? { get set }
    func moveToTokyo()
    func startTrack(at position: CLLocationCoordinate2D)
    func stopTrack()
}
