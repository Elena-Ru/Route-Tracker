//
//  MainViewBuilderTests.swift
//  RouteTrackerTests
//
//  Created by Елена Русских on 2024-01-09.
//

import XCTest
import SwiftUI
@testable import RouteTracker

// MARK: - MainViewBuilderTests
final class MainViewBuilderTests: XCTestCase {
    
    // MARK: Properties
    private var sut: MainViewBuilder!

    // MARK: Lifecycle
    override func setUp() {
        super.setUp()
        sut = MainViewBuilder()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: Tests
    func testMainViewBuilder_toPresent_ReturnsMainView() {
        // When
        let view = sut.toPresent()
        
        // Then
        XCTAssertNotNil(view, "The view should not be nil")
        XCTAssertTrue(view is MainView<MapViewModel>, "Returned view should be of type MainView<MapViewModel>")
    }
    
    func testMainViewBuilder_toPresent_ShouldReturnInstanceOfMainView() {
           // When
           let view = sut.toPresent()

           // Then
           XCTAssertNotNil(view, "The builder should always return an instance of MainView.")
           XCTAssertTrue(view is MainView<MapViewModel>, "The view returned by the builder should be an instance of MainView<MapViewModel>.")
       }
       
    func testMainViewBuilder_toPresent_ShouldSetUpViewModelCorrectly() {
        // When
        let view = sut.toPresent() as? MainView<MapViewModel>
        
        // Then
        XCTAssertNotNil(view?.viewModel, "The MainView instance should have a non-nil ViewModel.")
    }
}

