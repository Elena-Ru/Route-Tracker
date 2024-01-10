//
//  MapViewModel.swift
//  RouteTracker
//
//  Created by Елена Русских on 2024-01-09.
//

import GoogleMaps

// MARK: - MapViewModel
final class MapViewModel: NSObject, ObservableObject {
    
    // MARK: Properties
    @Published var cameraPosition: GMSCameraPosition
    @Published var markers: [GMSMarker] = [] 
    var locationManager: CLLocationManager?

    // MARK: Initializer
    init(
        latitude: CLLocationDegrees = Constants.latitudeDefault,
        longitude: CLLocationDegrees = Constants.longitudeDefault,
        zoom: Float = Constants.zoomDefault
    ) {
        cameraPosition = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: zoom)
        
        super.init()
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager?.allowsBackgroundLocationUpdates = true
        locationManager?.pausesLocationUpdatesAutomatically = false
        locationManager?.startMonitoringSignificantLocationChanges()
        locationManager?.requestAlwaysAuthorization()
    }
}

// MARK: - CLLocationManagerDelegate
extension MapViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            DispatchQueue.main.async {
                self.cameraPosition = GMSCameraPosition.camera(withTarget: location.coordinate, zoom: self.cameraPosition.zoom)
                let newMarker = GMSMarker(position: location.coordinate)
                self.markers.append(newMarker)
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to update location: \(error.localizedDescription)")
    }
}

// MARK: - MapViewModelProtocol
extension MapViewModel: MapViewModelProtocol {
    func moveToTokyo() {
        let dniproLatitude: CLLocationDegrees = Constants.latitudeTokyo
        let dniproLongitude: CLLocationDegrees = Constants.longitudeTokyo
        let zoomLevel: Float = Constants.zoomTokyo
        cameraPosition = GMSCameraPosition.camera(withLatitude: dniproLatitude, longitude: dniproLongitude, zoom: zoomLevel)
    }
    
    func addMarker(at position: CLLocationCoordinate2D) {
        locationManager?.startUpdatingLocation()
        markers.append(GMSMarker(position: position))
    }
}

// MARK: - Constants
private extension MapViewModel {
    enum Constants {
        static let latitudeDefault: CLLocationDegrees = -33.868
        static let longitudeDefault: CLLocationDegrees = 151.2086
        static let zoomDefault: Float = 6
        static let latitudeTokyo: CLLocationDegrees = 37.33527476
        static let longitudeTokyo: CLLocationDegrees = -122.03254703
        static let zoomTokyo: Float = 17
    }
}
