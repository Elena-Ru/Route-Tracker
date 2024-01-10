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
    @Published var markers: [GMSMarker] = [] 
    var locationManager: CLLocationManager?
    @Published var route: GMSPolyline?
    var routePath: GMSMutablePath?

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
        cameraPosition = GMSCameraPosition.camera(withLatitude: dniproLatitude, longitude: dniproLongitude, zoom: zoomLevel)
    }
    
    func startTrack(at position: CLLocationCoordinate2D) {
        route?.map = nil
        route = GMSPolyline()
        routePath = GMSMutablePath()
        
        locationManager?.startUpdatingLocation()
    }
    
    func stopTrack() {
            locationManager?.stopUpdatingLocation()
            
            // Предполагая, что у вас уже есть экземпляр Realm и routePath инициализирован.
            guard let path = routePath else {
                return
            }
            
            let realm = try! Realm() // Обычно вы обрабатываете ошибки при работе с Realm.
            
            try! realm.write {
                
                // Удаляем все существующие объекты RoutePoint из Realm
                let allRoutePoints = realm.objects(RoutePoint.self)
                realm.delete(allRoutePoints)
                
                for index in 0..<path.count() {
                    let coordinate = path.coordinate(at: index)
                    let routePoint = RoutePoint(latitude: coordinate.latitude, longitude: coordinate.longitude)
                    realm.add(routePoint)
                }
            }
            
            // Сброс или очистка маршрута, если это необходимо
            routePath = nil
            route?.map = nil
        }
}

// MARK: - Constants
private extension MapViewModel {
    enum Constants {
//        static let latitudeDefault: CLLocationDegrees = -33.868
//        static let longitudeDefault: CLLocationDegrees = 151.2086
//        static let zoomDefault: Float = 6
        static let latitudeTokyo: CLLocationDegrees = 37.33527476
        static let longitudeTokyo: CLLocationDegrees = -122.03254703
        static let zoomTokyo: Float = 17
    }
}
