//
//  MapViewModelTests.swift
//  RouteTrackerTests
//
//  Created by Елена Русских on 2024-01-09.
//

import XCTest
import GoogleMaps
@testable import RouteTracker

// MARK: - MapViewModelTests
final class MapViewModelTests: XCTestCase {
    
    // MARK: Properties
    private var sut: MapViewModel!
    
    // MARK: Lifecycle
    override func setUp() {
        super.setUp()
        sut = MapViewModel()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: Tests
    func testMapViewModel_WhenInitialized_ShouldHaveDefaultCameraPosition() {
        // Given
        let defaultLatitude = TestData.latitudeDefault
        let defaultLongitude = TestData.longitudeDefault
        let defaultZoom = TestData.zoomDefault
        
        // Then
        XCTAssertEqual(sut.cameraPosition.target.latitude, defaultLatitude, "Initial latitude should be set to default.")
        XCTAssertEqual(sut.cameraPosition.target.longitude, defaultLongitude, "Initial longitude should be set to default.")
        XCTAssertEqual(sut.cameraPosition.zoom, defaultZoom, "Initial zoom should be set to default.")
    }
    
    func testMapViewModel_WhenMoveToDnipro_ShouldUpdateCameraPositionToDnipro() {
        // When
        sut.moveToDnipro()
        
        // Then
        XCTAssertEqual(sut.cameraPosition.target.latitude, TestData.latitudeDnipro, "Latitude should be set to Dnipro's latitude.")
        XCTAssertEqual(sut.cameraPosition.target.longitude, TestData.longitudeDnipro, "Longitude should be set to Dnipro's longitude.")
        XCTAssertEqual(sut.cameraPosition.zoom, TestData.zoomDnipro, "Zoom should be set to Dnipro's zoom level.")
    }
}

private extension MapViewModelTests {
    enum TestData {
        static let latitudeDefault: CLLocationDegrees = -33.868
        static let longitudeDefault: CLLocationDegrees = 151.2086
        static let zoomDefault: Float = 6
        static let latitudeDnipro: CLLocationDegrees = 48.4647
        static let longitudeDnipro: CLLocationDegrees = 35.0462
        static let zoomDnipro: Float = 17
    }
}
