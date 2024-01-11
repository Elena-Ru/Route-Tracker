//
//  MainViewBuilder.swift
//  RouteTracker
//
//  Created by Елена Русских on 2024-01-09.
//

import SwiftUI

// MARK: - Builder
final class MapViewBuilder: BuilderProtocol {
    func toPresent() -> some View {
        let viewModel = MapViewModel()
        return MapView(viewModel: viewModel) 
    }
}
