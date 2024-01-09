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
    @Binding var cameraPosition: GMSCameraPosition
    @Binding var marker: GMSMarker?

    func makeUIView(context: Context) -> GMSMapView {
        let mapView = GMSMapView.init()
        mapView.camera = cameraPosition
        return mapView
    }
    
    func updateUIView(_ mapView: GMSMapView, context: Context) {
        mapView.animate(to: cameraPosition)
        mapView.clear()
        marker?.map = mapView
    }
}
