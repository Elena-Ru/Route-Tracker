//
//  MainViewBuilder.swift
//  RouteTracker
//
//  Created by Елена Русских on 2024-01-09.
//

import SwiftUI

// MARK: - Builder
final class MainViewBuilder: BuilderProtocol {
    func toPresent() -> some View {
        let viewModel = MapViewModel()
        return MainView(viewModel: viewModel) 
    }
}
