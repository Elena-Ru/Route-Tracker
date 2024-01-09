//
//  GoogleMapsView.swift
//  RouteTracker
//
//  Created by Елена Русских on 2024-01-09.
//

import SwiftUI
import GoogleMaps

// MARK: - GoogleMapsView
struct GoogleMapsView: UIViewRepresentable {
    func makeUIView(context: Context) -> GMSMapView {
        let coordinate = CLLocationCoordinate2D(latitude: Constants.latitude, longitude: Constants.longitude)
        let camera = GMSCameraPosition.camera(withTarget: coordinate, zoom: Constants.zoom)
        let mapView = GMSMapView.init()
        mapView.camera = camera
        return mapView
    }

    func updateUIView(_ mapView: GMSMapView, context: Context) {
    }
}

// MARK: - Constants
private extension GoogleMapsView {
    enum Constants {
        static let latitude: CLLocationDegrees = -33.868
        static let longitude: CLLocationDegrees = 151.2086
        static let zoom: Float = 17
    }
}
