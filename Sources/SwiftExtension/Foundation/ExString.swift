//
//  ExString.swift
//  Swift-Extensionn
//
//  Created by Anand Nimje on 27/01/18.
//  Copyright © 2018 Anand. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation

public extension String {

    /// The string with leading and trailing spaces and tabs removed.
    var trim: String {
        trimmingCharacters(in: .whitespaces)
    }

    /// The string with leading and trailing whitespace and newlines removed.
    var trimLine: String {
        trimmingCharacters(in: .whitespacesAndNewlines)
    }

    /// A Boolean value that indicates whether the string is non-empty and contains only ASCII letters and digits.
    var isAlphanumeric: Bool {
        isNotEmpty && allSatisfy { $0.isASCII && ($0.isLetter || $0.isNumber) }
    }

    /// A Boolean value that indicates whether the whole string is an email address.
    ///
    /// This checks a practical pattern, not the full RFC 5322 grammar.
    var isEmail: Bool {
        wholeMatch(of: #/[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,64}/#) != nil
    }

    /// A Boolean value that indicates whether the whole string is a nine- or ten-digit mobile number that starts with 1 through 9.
    var isMobile: Bool {
        wholeMatch(of: #/[1-9][0-9]{8}[0-9]?/#) != nil
    }

    /// A Boolean value that indicates whether the string is an absolute `http` or `https` URL with a host.
    var isValidURL: Bool {
        guard let url = URL(string: self), let scheme = url.scheme?.lowercased(),
            scheme == "http" || scheme == "https"
        else {
            return false
        }
        return url.host?.isEmpty == false
    }

    /// The uppercased initials of the first two words.
    ///
    /// ```swift
    /// "Anand Nimje".initials   // "AN"
    /// ```
    var initials: String {
        components(separatedBy: .whitespaces)
            .compactMap(\.first)
            .prefix(2)
            .map { String($0).uppercased() }
            .joined()
    }

    /// Converts a date written as `yyyy/M/dd` to a long date.
    ///
    /// ```swift
    /// "".changeDate("2026/1/05")   // "January 05, 2026"
    /// ```
    ///
    /// The receiver isn't used. Pass the date string as the argument.
    ///
    /// - Parameter mydate: A date in the form `yyyy/M/dd`, such as `"2026/1/05"`.
    /// - Returns: The date as `MMMM dd, yyyy`, or `nil` if the input can't be parsed.
    func changeDate(_ mydate: String) -> String? {
        guard let date = DateFormatter.posix("yyyy/M/dd").date(from: mydate) else { return nil }
        return DateFormatter.posix("MMMM dd, yyyy").string(from: date)
    }

    /// The string with its first character uppercased.
    ///
    /// ```swift
    /// "hello".firstLetterCapitalized   // "Hello"
    /// ```
    var firstLetterCapitalized: String {
        prefix(1).uppercased() + dropFirst()
    }

    /// Uppercases the first character of the string in place.
    mutating func capitalizeFirstLetter() {
        self = firstLetterCapitalized
    }

    /// The string with leading and trailing spaces and tabs removed.
    ///
    /// - Important: This is the same as ``trim``. Prefer `trim` in new code.
    func trimWhiteSpace() -> String {
        trim
    }

    /// The string with all spaces and tabs removed.
    var removeSpace: String {
        components(separatedBy: .whitespaces).joined()
    }

    /// Returns the string shortened to a number of characters, followed by a suffix if characters were removed.
    ///
    /// ```swift
    /// "Swift Extension".truncated(to: 5)   // "Swift…"
    /// ```
    ///
    /// - Parameters:
    ///   - length: The maximum number of characters to keep before the suffix.
    ///   - trailing: The text to append when characters are removed.
    /// - Returns: The original string if it already fits, otherwise the shortened string with `trailing`.
    func truncated(to length: Int, trailing: String = "…") -> String {
        guard length >= 0, count > length else { return self }
        return prefix(length) + trailing
    }
}
