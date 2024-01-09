//
//  ContentView.swift
//  RouteTracker
//
//  Created by Елена Русских on 2024-01-09.
//

import SwiftUI

// MARK: - MainView
struct MainView: View {
    var body: some View {
        GoogleMapsView()
            .edgesIgnoringSafeArea(.all)
    }
}

// MARK: - Preview
#Preview {
    MainView()
}
