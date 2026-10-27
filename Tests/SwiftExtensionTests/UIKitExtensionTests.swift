//  UIKitExtensionTests.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

#if canImport(UIKit)
import UIKit
import XCTest
import SwiftExtension

@MainActor
final class UIKitExtensionTests: XCTestCase {

    func testHexColorParsesRGBAndFallsBackToGray() {
        XCTAssertEqual(rgba(UIColor(hex: "#FF8000")), [1, 128.0 / 255, 0, 1])
        XCTAssertEqual(rgba(UIColor(hex: "FF000080"))[3], 128.0 / 255, accuracy: 0.001)
        XCTAssertEqual(rgba(UIColor(hex: "not a color")), [0.5, 0.5, 0.5, 1])
    }

    func testHexColorRejectsSignedInput() {
        XCTAssertEqual(rgba(UIColor(hex: "+FFFFF")), [0.5, 0.5, 0.5, 1])
    }

    func testHexStringRoundTrip() {
        XCTAssertEqual(UIColor(hex: "#61906B").hexString, "#61906B")
        XCTAssertEqual(UIColor(hex: "FF8000CC").hexString, "#FF8000")
    }

    func testImageResizeAndBase64() throws {
        let image = UIGraphicsImageRenderer(size: CGSize(width: 100, height: 40)).image { _ in }
        XCTAssertEqual(try XCTUnwrap(image.halfSizeImage).size, CGSize(width: 50, height: 20))
        XCTAssertEqual(try XCTUnwrap(image.quarterhalfSizeImage).size, CGSize(width: 25, height: 10))
        XCTAssertNotNil(image.toBase64String)
    }

    func testPinToEdgesUsesInsets() {
        let superview = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        let child = UIView()
        child.pinToEdges(of: superview, insets: NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 30, trailing: 40))
        superview.layoutIfNeeded()
        XCTAssertTrue(child.superview === superview)
        XCTAssertEqual(child.frame, CGRect(x: 20, y: 10, width: 140, height: 60))
    }

    func testAddSubviewsAddsEachView() {
        let container = UIView()
        container.addSubviews(UIView(), UIView())
        XCTAssertEqual(container.subviews.count, 2)
    }

    func testLabelHelpers() {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.text = "Hi"

        label.underline()
        XCTAssertEqual(
            label.attributedText?.attribute(.underlineStyle, at: 0, effectiveRange: nil) as? Int, NSUnderlineStyle.single.rawValue)

        label.attribute("A", effect: "B")
        XCTAssertEqual(label.attributedText?.string, "AB")

        label.setRight()
        XCTAssertEqual(label.textAlignment, .right)
        label.setLeft()
        XCTAssertEqual(label.textAlignment, .left)
    }

    func testAttributedStringBuilders() {
        let result = NSMutableAttributedString().bold("A").normal("B")
        XCTAssertEqual(result.string, "AB")
        XCTAssertNotNil(result.attribute(.font, at: 0, effectiveRange: nil))
    }

    func testScrollViewHelpers() {
        let scroll = UIScrollView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        scroll.contentSize = CGSize(width: 100, height: 500)

        scroll.scrollToBottom(animated: false)
        XCTAssertEqual(scroll.contentOffset.y, 400, accuracy: 0.5)

        scroll.scrollToTop(animated: false)
        XCTAssertEqual(scroll.contentOffset.y, 0, accuracy: 0.5)

        let target = UIView(frame: CGRect(x: 0, y: 300, width: 100, height: 50))
        scroll.addSubview(target)
        scroll.scrollToView(view: target, animated: false)
        XCTAssertEqual(scroll.contentOffset.y, 300, accuracy: 0.5)
    }

    func testTextFieldHelpers() {
        let field = UITextField(frame: CGRect(x: 0, y: 0, width: 100, height: 30))

        field.text = "a@b.co"
        XCTAssertTrue(field.isValidEmail)
        field.text = "not an email"
        XCTAssertFalse(field.isValidEmail)

        field.text = "12345"
        XCTAssertFalse(field.isPhoneNumber)

        field.setLeftPaddingPoints(12)
        field.setRightPaddingPoints(8)
        XCTAssertEqual(field.leftView?.frame.width, 12)
        XCTAssertEqual(field.rightView?.frame.width, 8)

        field.setBorderAndCorner(color: .red)
        XCTAssertEqual(field.layer.cornerRadius, 5)
        XCTAssertEqual(field.layer.borderWidth, 1)
    }

    func testNavigationBarHelpers() {
        let bar = UINavigationBar()

        bar.setColors(background: .red, text: .white)
        XCTAssertEqual(bar.standardAppearance.backgroundColor, .red)
        XCTAssertEqual(bar.tintColor, .white)

        bar.makeTransparent(withTint: .blue)
        XCTAssertEqual(bar.tintColor, .blue)

        bar.setTitleFont(.boldSystemFont(ofSize: 20))
        XCTAssertNotNil(bar.standardAppearance.titleTextAttributes[.font])
    }

    func testImageViewCornerHelpers() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        imageView.setRounded()
        XCTAssertEqual(imageView.layer.cornerRadius, 50)
        imageView.setCornerRadius()
        XCTAssertEqual(imageView.layer.cornerRadius, 2)
    }

    func testImageLoadsFromFilePath() throws {
        let image = UIGraphicsImageRenderer(size: CGSize(width: 10, height: 10)).image { _ in }
        let url = FileManager.default.temporaryDirectory.appendingPathComponent("swiftextension-\(UUID().uuidString).png")
        try XCTUnwrap(image.pngData()).write(to: url)
        defer { try? FileManager.default.removeItem(at: url) }

        XCTAssertNotNil(image.loadImageFromDocumentDirPath(url.path))
        XCTAssertNil(image.loadImageFromDocumentDirPath("/definitely/missing.png"))
    }

    func testLegacyHexHelperMatchesUIColor() {
        XCTAssertEqual(rgba(ExFunction.hexStringToUIColor(hex: "#FF0000")), [1, 0, 0, 1])
    }

    func testAlertsPresentAndAutoDismiss() async throws {
        let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 320, height: 480))
        let root = UIViewController()
        window.rootViewController = root
        window.makeKeyAndVisible()

        root.showAlertView(title: "Title", message: "Body")
        XCTAssertTrue(root.presentedViewController is UIAlertController)
        root.dismiss(animated: false)

        let finished = expectation(description: "completion called")
        root.showAlertWithMessage("Saved", duration: .milliseconds(50)) { finished.fulfill() }
        XCTAssertTrue(root.presentedViewController is UIAlertController)
        await fulfillment(of: [finished], timeout: 3)
    }

    private func rgba(_ color: UIColor) -> [CGFloat] {
        var (r, g, b, a): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
        color.getRed(&r, green: &g, blue: &b, alpha: &a)
        return [r, g, b, a]
    }
}
#endif
