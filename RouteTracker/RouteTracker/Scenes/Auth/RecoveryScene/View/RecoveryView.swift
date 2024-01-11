//
//  RecoveryView.swift
//  RouteTracker
//
//  Created by Елена Русских on 2024-01-11.
//

import SwiftUI

// MARK: - RecoveryView
struct RecoveryView: View {
    // MARK: Properties
    @State private var username: String = ""

    var body: some View {
        NavigationView {
            VStack {
                TextField(Constants.loginPlaceholder, text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding()
                
                Button(Constants.secondaryButtonTitle) {
                    guard
                        !username.isEmpty,
                        username == Constants.userName
                    else {
                        return
                    }
                    print("Recover")
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(Constants.cornerRadius)
                .padding()
            }
        }
    }
}
// MARK: - Constants
private extension RecoveryView {
    enum Constants {
        static let cornerRadius: CGFloat = 10
        static let secondaryButtonTitle: String = "Recover password"
        static let userName: String = "11"
        static let password: String = "111"
        static let loginPlaceholder: String = "User login"
    }
}

// MARK: - Preview
#Preview {
    RecoveryView()
}
