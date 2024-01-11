//
//  LoginViewBuilder.swift
//  RouteTracker
//
//  Created by Елена Русских on 2024-01-11.
//

import SwiftUI

// MARK: - LoginViewBuilder
final class LoginViewBuilder: BuilderProtocol {
    func toPresent() -> some View {
        let viewModel = LoginViewModel()
        return LoginView(viewModel: viewModel)
    }
}
