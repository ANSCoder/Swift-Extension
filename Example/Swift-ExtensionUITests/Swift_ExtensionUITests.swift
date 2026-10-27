//
//  Swift_ExtensionUITests.swift
//  Swift-ExtensionUITests
//
//  MIT License, see LICENSE in the repository root.
//

import XCTest

@MainActor
final class SwiftExtensionUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testDemoScreenLaunches() {
        let app = XCUIApplication()
        app.launch()
        XCTAssertTrue(app.navigationBars["SwiftUI Extensions"].waitForExistence(timeout: 5))
    }
}
