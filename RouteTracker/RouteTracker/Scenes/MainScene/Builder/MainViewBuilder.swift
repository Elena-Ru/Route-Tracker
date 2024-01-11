//
//  MainViewBuilder.swift
//  RouteTracker
//
//  Created by Елена Русских on 2024-01-11.
//

import SwiftUI

// MARK: - MainViewBuilder
final class MainViewBuilder: BuilderProtocol {
    func toPresent() -> some View {
        let viewModel = MainViewModel()
        return MainView(viewModel: viewModel)
    }
}
