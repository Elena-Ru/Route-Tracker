//
//  MainView.swift
//  RouteTracker
//
//  Created by Елена Русских on 2024-01-11.
//

import SwiftUI

// MARK: - MainView
struct MainView<VM>: View where VM: MainViewModelProtocol {
    
    // MARK: Properties
    @ObservedObject var viewModel: VM
    
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
                    UserDefaults.standard.setValue(false, forKey: "isLogin")
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
        static var cornerRadius: CGFloat { 10 }
        static var secondaryButtonTitle: String { "Exit" }
        static var primaryButtonTitle: String { "Show the Map" }
    }
}

// MARK: - Preview
#Preview {
    MainView(viewModel: MainViewModel())
}
