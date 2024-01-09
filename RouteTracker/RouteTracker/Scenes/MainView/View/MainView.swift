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
            GoogleMapsView(cameraPosition: $viewModel.cameraPosition, markers: $viewModel.markers)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(Constants.navigateToTokyo) {
                            viewModel.moveToTokyo()
                        }
                    }
                    ToolbarItem(placement: .topBarLeading) {
                        Button(Constants.addMarker) {
                            let currentPosition = viewModel.cameraPosition.target
                            viewModel.addMarker(at: currentPosition)
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
        static var addMarker: String { "Marker" }
    }
}
