//
//  ContentView.swift
//  RouteTracker
//
//  Created by Елена Русских on 2024-01-09.
//

import SwiftUI
import CoreLocation

// MARK: - MainView
struct MapView<VM>: View where VM: MapViewModelProtocol {
    
    // MARK: Properties
    @ObservedObject var viewModel: VM
       
    var body: some View {
        NavigationView {
            GoogleMapsView(cameraPosition: $viewModel.cameraPosition, lastCameraUpdate: $viewModel.lastCameraUpdate, route: $viewModel.route, needsCameraUpdate: $viewModel.needsCameraUpdate)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                            Button(Constants.previous) {
                                viewModel.showPreviousTrack()
                            }
                    }
                    
                    ToolbarItem(placement: .topBarLeading) {
                        HStack {
                            Button(Constants.startTrack) {
                                let currentPosition = viewModel.cameraPosition.target
                                viewModel.startTrack(at: currentPosition)
                            }
                            
                            Button(Constants.stopTrack) {
                                viewModel.stopTrack()
                            }
                        }
                    }
                }
                .alert(isPresented: $viewModel.showAlert) {
                    Alert(
                        title: Text(Constants.alertTitle),
                        message: Text(Constants.alertMessage),
                        dismissButton: .default(Text(Constants.ok), action: {
                            viewModel.stopTrack()
                        })
                    )
                }
        }
    }
}

// MARK: - Preview
#Preview {
    MapView(viewModel: MapViewModel())
}

// MARK: - Constants
private extension MapView {
    enum Constants {
        static var startTrack: String { "Start track" }
        static var stopTrack: String { "Stop track" }
        static var previous: String { "Previuos" }
        static var ok: String { "Ok" }
        static var alertTitle: String { "Tracking is active" }
        static var alertMessage: String { "Tracking must be stopped first." }
    }
}
