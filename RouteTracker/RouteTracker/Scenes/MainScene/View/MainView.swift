//
//  MainView.swift
//  RouteTracker
//
//  Created by Елена Русских on 2024-01-11.
//

import SwiftUI

// MARK: - MainView
struct MainView: View {
    var body: some View {
        NavigationView {
            VStack {
                Button(Constants.primaryButtonTitle) {
                    
                    print("show map")
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(Constants.cornerRadius)
                
                Button(Constants.secondaryButtonTitle) {
                    print("exit")
                }
                .padding()
            }
        }
    }
}

// MARK: - Constants
private extension MainView {
    enum Constants {
        static let cornerRadius: CGFloat = 10
        static let secondaryButtonTitle: String = "Exit"
        static let primaryButtonTitle: String = "Show the Map"
    }
}

// MARK: - Preview
#Preview {
    MainView()
}
