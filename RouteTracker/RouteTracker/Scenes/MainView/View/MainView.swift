//
//  ContentView.swift
//  RouteTracker
//
//  Created by Елена Русских on 2024-01-09.
//

import SwiftUI
import CoreLocation

// MARK: - MainView
struct MainView<VM>: View where VM: MapViewModelProtocol {
    
    // MARK: Properties
    @ObservedObject var viewModel: VM
       
    var body: some View {
        NavigationView {
            GoogleMapsView(cameraPosition: $viewModel.cameraPosition, lastCameraUpdate: $viewModel.lastCameraUpdate, markers: $viewModel.markers, route: $viewModel.route, needsCameraUpdate: $viewModel.needsCameraUpdate)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        HStack {
                            Button(Constants.previous) {
                                viewModel.showPreviousTrack()
                            }
                            
                            Button(Constants.navigateToTokyo) {
                                viewModel.moveToTokyo()
                            }
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
        }
    }
}

// MARK: - Preview
#Preview {
    MainView(viewModel: MapViewModel())
}

// MARK: - Constants
private extension MainView {
    enum Constants {
        static var navigateToTokyo: String { "To Tokyo" }
        static var startTrack: String { "Start track" }
        static var stopTrack: String { "Stop track" }
        static var previous: String { "Previuos" }
    }
}
