//  SwiftUIExtensionTests.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

#if canImport(UIKit)
import SwiftUI
import XCTest
@testable import SwiftExtension

@MainActor
final class SwiftUIExtensionTests: XCTestCase {

    func testSnapshotMatchesViewSizeAndScale() throws {
        let image = try XCTUnwrap(Color.red.frame(width: 40, height: 20).snapshot(scale: 2))
        XCTAssertEqual(image.size, CGSize(width: 40, height: 20))
        XCTAssertEqual(image.scale, 2)
    }

    func testSwiftUIColorHexRoundTrips() {
        XCTAssertEqual(UIColor(Color(hex: "#3366FF")).hexString, "#3366FF")
    }

    func testClampedWorksOnCGFloat() {
        XCTAssertEqual(CGFloat(300).clamped(to: -120...120), 120)
        XCTAssertEqual(CGFloat(-5).clamped(to: -120...120), -5)
    }

    func testShakeEffectOffsetFollowsProgress() {
        XCTAssertEqual(ShakeEffect(progress: 0).effectValue(size: .zero).m31, 0, accuracy: 0.001)
        XCTAssertEqual(ShakeEffect(progress: 0.125).effectValue(size: .zero).m31, 10, accuracy: 0.001)
        XCTAssertEqual(ShakeEffect(progress: 0.125, amplitude: 4).effectValue(size: .zero).m31, 4, accuracy: 0.001)
    }

    func testViewHelpersRenderAndFirstAppearFiresOnce() async {
        let appeared = expectation(description: "first appear")
        appeared.assertForOverFulfill = true
        var message: String? = "Oops"

        let view = Text("Hello")
            .if(true) { $0.bold() }
            .ifLet(Optional("x")) { view, _ in view.italic() }
            .hidden(if: false)
            .cardStyle()
            .roundedBorder(.red)
            .shake(trigger: 0)
            .shimmer(false)
            .redactedShimmer(false)
            .loadingOverlay(false)
            .errorAlert(message: Binding(get: { message }, set: { message = $0 }))
            .dismissKeyboardOnTap()
            .onSizeChange { _ in }
            .onFirstAppear { appeared.fulfill() }

        let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 320, height: 480))
        window.rootViewController = UIHostingController(rootView: view)
        window.makeKeyAndVisible()
        window.rootViewController?.view.layoutIfNeeded()

        await fulfillment(of: [appeared], timeout: 3)
    }
}
#endif
