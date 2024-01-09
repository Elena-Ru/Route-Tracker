//
//  ContentView.swift
//  RouteTracker
//
//  Created by Елена Русских on 2024-01-09.
//

import SwiftUI

// MARK: - MainView
struct MainView<VM>: View where VM: MapViewModelProtocol {
    
    // MARK: Properties
    @ObservedObject var viewModel: VM
       
    var body: some View {
        NavigationView {
            GoogleMapsView(cameraPosition: $viewModel.cameraPosition)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(Constants.navigateToDnipro) {
                            viewModel.moveToDnipro()
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
        static var navigateToDnipro: String { "To Dnipro" }
    }
}
