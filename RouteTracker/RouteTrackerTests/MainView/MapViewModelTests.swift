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
        sut.moveToTokyo()
        
        // Then
        XCTAssertEqual(sut.cameraPosition.target.latitude, TestData.latitudeTokyo, "Latitude should be set to Tokyo's latitude.")
        XCTAssertEqual(sut.cameraPosition.target.longitude, TestData.longitudeTokyo, "Longitude should be set to Tokyo's longitude.")
        XCTAssertEqual(sut.cameraPosition.zoom, TestData.zoomTokyo, "Zoom should be set to Tokyo's zoom level.")
    }
}

private extension MapViewModelTests {
    enum TestData {
        static let latitudeDefault: CLLocationDegrees = -33.868
        static let longitudeDefault: CLLocationDegrees = 151.2086
        static let zoomDefault: Float = 6
        static let latitudeTokyo: CLLocationDegrees = 37.33527476
        static let longitudeTokyo: CLLocationDegrees = -122.03254703
        static let zoomTokyo: Float = 17
    }
}
