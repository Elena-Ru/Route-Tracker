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
    @Binding var lastCameraUpdate: GMSCameraUpdate?
    @Binding var route: GMSPolyline?
    @Binding var needsCameraUpdate: Bool

    func makeUIView(context: Context) -> GMSMapView {
        let mapView = GMSMapView.init()
        mapView.camera = cameraPosition
        return mapView
    }
    
    func updateUIView(_ mapView: GMSMapView, context: Context) {
        if let cameraUpdate = self.lastCameraUpdate {
            mapView.animate(with: cameraUpdate)
            DispatchQueue.main.async {
                self.lastCameraUpdate = nil
                self.needsCameraUpdate = false
            }
            route?.map = mapView
            return
        }
        if needsCameraUpdate {
            mapView.animate(to: cameraPosition)
            route?.map = mapView
        }
    }
}
