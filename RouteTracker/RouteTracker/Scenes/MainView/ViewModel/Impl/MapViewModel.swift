//
//  MapViewModel.swift
//  RouteTracker
//
//  Created by Елена Русских on 2024-01-09.
//

import GoogleMaps
import RealmSwift

// MARK: - MapViewModel
final class MapViewModel: NSObject, ObservableObject {
    
    // MARK: Properties
    @Published var cameraPosition: GMSCameraPosition
    @Published var lastCameraUpdate: GMSCameraUpdate?
    @Published var route: GMSPolyline?
    @Published var needsCameraUpdate: Bool = false
    var routePath: GMSMutablePath?
    var isTracking: Bool = false
    var locationManager: CLLocationManager?

    // MARK: Initializer
    init(
        latitude: CLLocationDegrees = Constants.latitudeTokyo,
        longitude: CLLocationDegrees = Constants.longitudeTokyo,
        zoom: Float = Constants.zoomTokyo
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
        guard isTracking else { return }

        if let location = locations.last {
            DispatchQueue.main.async {
                self.cameraPosition = GMSCameraPosition.camera(withTarget: location.coordinate, zoom: self.cameraPosition.zoom)
                self.routePath?.add(location.coordinate)
                self.route?.path = self.routePath
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
        DispatchQueue.main.async {
            self.cameraPosition = GMSCameraPosition.camera(withLatitude: dniproLatitude, longitude: dniproLongitude, zoom: zoomLevel)
        }
    }
    
    func startTrack(at position: CLLocationCoordinate2D) {
        isTracking = true
        needsCameraUpdate = true
        route?.map = nil
        route = GMSPolyline()
        routePath = GMSMutablePath()
        locationManager?.startUpdatingLocation()
    }
    
    func stopTrack() {
        locationManager?.stopUpdatingLocation()
        isTracking = false
        
        guard let path = routePath else {
            return
        }
        
        let realm = try! Realm()
        
        try! realm.write {
            
            let allRoutePoints = realm.objects(RoutePoint.self)
            realm.delete(allRoutePoints)
            
            for index in 0..<path.count() {
                let coordinate = path.coordinate(at: index)
                let routePoint = RoutePoint(latitude: coordinate.latitude, longitude: coordinate.longitude)
                realm.add(routePoint)
            }
        }
        
        routePath = nil
        route?.map = nil
    }
    
    func showPreviousTrack() {
        let realm = try! Realm()
        
        let savedRoutePoints = realm.objects(RoutePoint.self)
        
        let path = GMSMutablePath()
        savedRoutePoints.forEach { routePoint in
            path.add(CLLocationCoordinate2D(latitude: routePoint.latitude, longitude: routePoint.longitude))
        }
        
        if path.count() > 0 {
            DispatchQueue.main.async {
                let polyline = GMSPolyline(path: path)
                self.route = polyline
                
                let bounds = GMSCoordinateBounds(path: path)
                let update = GMSCameraUpdate.fit(bounds, withPadding: 50)
                
                self.lastCameraUpdate = update 
                self.needsCameraUpdate = true
            }
        }
    }
}

// MARK: - Constants
private extension MapViewModel {
    enum Constants {
        static let latitudeTokyo: CLLocationDegrees = 37.33527476
        static let longitudeTokyo: CLLocationDegrees = -122.03254703
        static let zoomTokyo: Float = 17
    }
}
