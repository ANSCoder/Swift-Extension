//  FoundationExtensionTests.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import XCTest
import SwiftExtension

final class FoundationExtensionTests: XCTestCase {

    func testArrayAtIndexReturnsNilOutOfBounds() {
        let items = ["a", "b"]
        XCTAssertEqual(items.atIndex(1), "b")
        XCTAssertNil(items.atIndex(2))
        XCTAssertNil(items.atIndex(-1))
    }

    func testChunkedIntoSizes() {
        XCTAssertEqual([1, 2, 3, 4, 5].chunked(into: 2), [[1, 2], [3, 4], [5]])
        XCTAssertEqual([Int]().chunked(into: 3), [])
    }

    func testRemovingDuplicatesKeepsFirstOccurrence() {
        XCTAssertEqual(["a", "b", "A", "c"].removingDuplicates(on: { $0.lowercased() }), ["a", "b", "c"])
    }

    func testIsNotEmptyOnCollections() {
        XCTAssertFalse([Int]().isNotEmpty)
        XCTAssertTrue([1].isNotEmpty)
        XCTAssertTrue("x".isNotEmpty)
    }

    func testClampedToRange() {
        XCTAssertEqual(15.clamped(to: 0...10), 10)
        XCTAssertEqual((-3).clamped(to: 0...10), 0)
        XCTAssertEqual(5.clamped(to: 0...10), 5)
    }

    func testRoundedToPlaces() {
        XCTAssertEqual(3.14159.rounded(toPlaces: 2), 3.14)
        XCTAssertEqual(2.5.rounded(toPlaces: 0), 3)
    }

    func testOptionalStringOrEmpty() {
        let missing: String? = nil
        XCTAssertEqual(missing.orEmpty, "")
        XCTAssertEqual(Optional("hi").orEmpty, "hi")
    }

    func testEmailValidation() {
        XCTAssertTrue("john.doe+tag@example.co.uk".isEmail)
        XCTAssertTrue("hello@site.museum".isEmail)
        XCTAssertFalse("john@".isEmail)
        XCTAssertFalse("john@example.com extra".isEmail)
    }

    func testMobileValidation() {
        XCTAssertTrue("9876543210".isMobile)
        XCTAssertTrue("987654321".isMobile)
        XCTAssertFalse("0876543210".isMobile)
        XCTAssertFalse("98765".isMobile)
    }

    func testAlphanumeric() {
        XCTAssertTrue("Abc123".isAlphanumeric)
        XCTAssertFalse("Abc 123".isAlphanumeric)
        XCTAssertFalse("café".isAlphanumeric)
        XCTAssertFalse("".isAlphanumeric)
    }

    func testValidURL() {
        XCTAssertTrue("https://example.com/path?q=1".isValidURL)
        XCTAssertTrue("http://localhost:8080".isValidURL)
        XCTAssertFalse("example.com".isValidURL)
        XCTAssertFalse("ftp://example.com".isValidURL)
        XCTAssertFalse("https://".isValidURL)
    }

    func testInitials() {
        XCTAssertEqual("Anand Nimje".initials, "AN")
        XCTAssertEqual("madonna".initials, "M")
        XCTAssertEqual("ana maria  lopez".initials, "AM")
        XCTAssertEqual("".initials, "")
    }

    func testTrimAndCapitalize() {
        XCTAssertEqual("  hi there \n".trim, "hi there \n")
        XCTAssertEqual("  hi\n".trimLine, "hi")
        XCTAssertEqual("hello world".removeSpace, "helloworld")
        XCTAssertEqual("".firstLetterCapitalized, "")

        var word = "swift"
        word.capitalizeFirstLetter()
        XCTAssertEqual(word, "Swift")
    }

    func testChangeDateFormatsOrReturnsNil() {
        XCTAssertEqual("".changeDate("2026/1/05"), "January 05, 2026")
        XCTAssertNil("".changeDate("not a date"))
    }

    func testDateFormatting() throws {
        let date = try XCTUnwrap(
            Calendar(identifier: .gregorian)
                .date(from: DateComponents(year: 2026, month: 1, day: 5, hour: 9, minute: 7)))
        XCTAssertEqual(date.toString(), "05-01-2026")
        XCTAssertEqual(date.toTimeString(), "09:07")
    }

    func testDateHelpers() throws {
        let calendar = Calendar(identifier: .gregorian)
        let morning = try XCTUnwrap(calendar.date(from: DateComponents(year: 2026, month: 1, day: 5, hour: 9)))
        let evening = try XCTUnwrap(calendar.date(from: DateComponents(year: 2026, month: 1, day: 5, hour: 21)))
        let nextWeek = try XCTUnwrap(calendar.date(from: DateComponents(year: 2026, month: 1, day: 12, hour: 9)))

        XCTAssertTrue(morning.isSameDay(as: evening, calendar: calendar))
        XCTAssertEqual(morning.adding(.day, value: 7, calendar: calendar), nextWeek)
        XCTAssertEqual(Calendar.current.component(.hour, from: evening.startOfDay), 0)
        XCTAssertTrue(Date().isToday)
    }

    func testDictionaryEncoding() throws {
        let input: [String: String] = ["name": "Zoë"]
        let dictionary = try input.asDictionary()
        XCTAssertEqual(dictionary["name"] as? String, "Zoë")
        XCTAssertThrowsError(try 5.asDictionary())
    }

    func testJSONRoundTripKeepsNonASCII() {
        let dictionary = ExFunction.convertStringToDictionary(#"{"name":"Zoë","count":2}"#)
        XCTAssertEqual(dictionary["name"] as? String, "Zoë")

        let json = ExFunction.getRawJSON(from: dictionary)
        XCTAssertEqual(ExFunction.convertStringToDictionary(json)["count"] as? Int, 2)
        XCTAssertTrue(ExFunction.convertStringToDictionary("[1, 2]").isEmpty)
    }

    func testTruncated() {
        XCTAssertEqual("Swift Extension".truncated(to: 5), "Swift…")
        XCTAssertEqual("Swift".truncated(to: 5), "Swift")
        XCTAssertEqual("Hello".truncated(to: 0, trailing: "..."), "...")
    }

    func testURLQueryItems() throws {
        let url = try XCTUnwrap(URL(string: "https://swift.org/docs?lang=en&sort=new"))
        XCTAssertEqual(url.queryItems, ["lang": "en", "sort": "new"])

        let updated = url.appendingQueryItems(["sort": "old", "ref": "x"])
        XCTAssertEqual(updated.queryItems, ["lang": "en", "sort": "old", "ref": "x"])
    }

    func testBundleVersionsAreNeverEmpty() {
        let bundle = Bundle(for: FoundationExtensionTests.self)
        XCTAssertFalse(bundle.appVersion.isEmpty)
        XCTAssertFalse(bundle.buildNumber.isEmpty)
    }
}
