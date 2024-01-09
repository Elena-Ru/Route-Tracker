//
//  BuilderProtocol.swift
//  RouteTracker
//
//  Created by Елена Русских on 2024-01-09.
//

import SwiftUI

// MARK: - BuilderProtocol
protocol BuilderProtocol {
    associatedtype view: View
    func toPresent() -> view
}
