//
//  MapViewModel.swift
//  RouteTracker
//
//  Created by Елена Русских on 2024-01-09.
//

import GoogleMaps

// MARK: - MapViewModel
final class MapViewModel: ObservableObject {
    // MARK: Properties
    @Published var cameraPosition: GMSCameraPosition
    @Published var marker: GMSMarker?

    // MARK: Initializer
    init(
        latitude: CLLocationDegrees = Constants.latitudeDefault,
        longitude: CLLocationDegrees = Constants.longitudeDefault,
        zoom: Float = Constants.zoomDefault
    ) {
        cameraPosition = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: zoom)
    }
}

// MARK: - MapViewModelProtocol
extension MapViewModel: MapViewModelProtocol {
    func moveToDnipro() {
        let dniproLatitude: CLLocationDegrees = Constants.latitudeDnipro
        let dniproLongitude: CLLocationDegrees = Constants.longitudeDnipro
        let zoomLevel: Float = Constants.zoomDnipro
        cameraPosition = GMSCameraPosition.camera(withLatitude: dniproLatitude, longitude: dniproLongitude, zoom: zoomLevel)
    }
    
    func addMarker(at position: CLLocationCoordinate2D) {
        marker = GMSMarker(position: position)
    }
}

// MARK: - Constants
private extension MapViewModel {
    enum Constants {
        static let latitudeDefault: CLLocationDegrees = -33.868
        static let longitudeDefault: CLLocationDegrees = 151.2086
        static let zoomDefault: Float = 6
        static let latitudeDnipro: CLLocationDegrees = 48.4647
        static let longitudeDnipro: CLLocationDegrees = 35.0462
        static let zoomDnipro: Float = 17
    }
}
