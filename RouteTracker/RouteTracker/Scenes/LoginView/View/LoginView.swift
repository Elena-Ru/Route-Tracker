//
//  LoginView.swift
//  RouteTracker
//
//  Created by Елена Русских on 2024-01-11.
//

import SwiftUI

// MARK: - LoginView
struct LoginView: View {
    // MARK: Properties
    @State private var username: String = ""
    @State private var password: String = ""

    var body: some View {
        NavigationView {
            VStack {
                TextField(Constants.loginPlaceholder, text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding()
                
                SecureField(Constants.passwordPlaceholder, text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(Constants.primaryButtonTitle) {
                    guard
                        !username.isEmpty,
                        !password.isEmpty,
                        username == Constants.userName,
                        password == Constants.password
                    else {
                        return
                    }
                    print("login")
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(Constants.cornerRadius)
                
                Button(Constants.secondaryButtonTitle) {
                }
                .padding()
            }
        }
    }
}
// MARK: - Constants
private extension LoginView {
    enum Constants {
        static let cornerRadius: CGFloat = 10
        static let secondaryButtonTitle: String = "Recover password"
        static let userName: String = "11"
        static let password: String = "111"
        static let primaryButtonTitle: String = "Login"
        static let passwordPlaceholder: String = "Password"
        static let loginPlaceholder: String = "User login"
    }
}

// MARK: - LoginView
#Preview {
    LoginView()
}
