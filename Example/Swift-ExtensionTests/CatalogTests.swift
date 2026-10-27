//  CatalogTests.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import XCTest
@testable import Swift_Extension

/// Guards the catalog itself: every example must be complete and easy to tell apart.
@MainActor
final class CatalogTests: XCTestCase {

    func testEveryExampleHasTitleSummaryCodeAndHint() {
        for example in Example.allCases {
            XCTAssertFalse(example.info.title.isEmpty, "\(example) has no title")
            XCTAssertFalse(example.info.summary.isEmpty, "\(example) has no summary")
            XCTAssertFalse(example.info.code.isEmpty, "\(example) has no code")
            XCTAssertFalse(example.playHint.isEmpty, "\(example) has no play hint")
        }
    }

    func testTitlesAreUnique() {
        let titles = Example.allCases.map(\.info.title)
        XCTAssertEqual(Set(titles).count, titles.count)
    }

    func testEveryCategoryHasExamples() {
        for category in ExampleCategory.allCases {
            XCTAssertTrue(
                Example.allCases.contains { $0.info.category == category },
                "\(category.title) is empty"
            )
        }
    }
}
