//
//  LoginView.swift
//  RouteTracker
//
//  Created by Елена Русских on 2024-01-11.
//

import SwiftUI

// MARK: - LoginView
struct LoginView<VM>: View where VM: LoginViewModelProtocol {
    
    // MARK: Properties
    @ObservedObject var viewModel: VM
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
                    UserDefaults.standard.setValue(true, forKey: "isLogin")
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
        static var cornerRadius: CGFloat { 10 }
        static var secondaryButtonTitle: String { "Recover password" }
        static var userName: String { "11" }
        static var password: String { "111" }
        static var primaryButtonTitle: String { "Login" }
        static var passwordPlaceholder: String { "Password" }
        static var loginPlaceholder: String { "User login" }
    }
}

// MARK: - Preview
#Preview {
    LoginView(viewModel: LoginViewModel())
}
