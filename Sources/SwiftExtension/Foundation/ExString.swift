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

    /// The string without leading and trailing spaces and tabs.
    var trim: String {
        trimmingCharacters(in: .whitespaces)
    }

    /// The string without leading and trailing whitespace and newlines.
    var trimLine: String {
        trimmingCharacters(in: .whitespacesAndNewlines)
    }

    /// `true` when the string is non-empty and contains only ASCII letters and digits.
    var isAlphanumeric: Bool {
        isNotEmpty && allSatisfy { $0.isASCII && ($0.isLetter || $0.isNumber) }
    }

    /// `true` when the whole string is an email address.
    var isEmail: Bool {
        wholeMatch(of: #/[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,64}/#) != nil
    }

    /// `true` when the whole string is a 9 or 10 digit mobile number starting with 1-9.
    var isMobile: Bool {
        wholeMatch(of: #/[1-9][0-9]{8}[0-9]?/#) != nil
    }

    /// `true` when the string is an `http` or `https` URL with a host.
    var isValidURL: Bool {
        guard let url = URL(string: self), let scheme = url.scheme?.lowercased(),
            scheme == "http" || scheme == "https"
        else {
            return false
        }
        return url.host?.isEmpty == false
    }

    /// Uppercased initials of the first two words, e.g. `Anand Nimje` is `AN`.
    var initials: String {
        components(separatedBy: .whitespaces)
            .compactMap(\.first)
            .prefix(2)
            .map { String($0).uppercased() }
            .joined()
    }

    /// Converts a `yyyy/M/dd` date string to `MMMM dd, yyyy`, e.g. `2026/1/05` to `January 05, 2026`. Returns `nil` when it cannot be parsed.
    func changeDate(_ mydate: String) -> String? {
        guard let date = DateFormatter.posix("yyyy/M/dd").date(from: mydate) else { return nil }
        return DateFormatter.posix("MMMM dd, yyyy").string(from: date)
    }

    /// The string with its first character uppercased, e.g. `hello` becomes `Hello`.
    var firstLetterCapitalized: String {
        prefix(1).uppercased() + dropFirst()
    }

    /// Uppercases the first character in place.
    mutating func capitalizeFirstLetter() {
        self = firstLetterCapitalized
    }

    /// The string without leading and trailing spaces and tabs. Same as ``trim``.
    func trimWhiteSpace() -> String {
        trim
    }

    /// The string without any spaces or tabs.
    var removeSpace: String {
        components(separatedBy: .whitespaces).joined()
    }

    /// The string cut to `length` characters, with `trailing` appended only when something was cut.
    ///
    /// ```swift
    /// "Swift Extension".truncated(to: 5)   // "Swift…"
    /// ```
    func truncated(to length: Int, trailing: String = "…") -> String {
        guard length >= 0, count > length else { return self }
        return prefix(length) + trailing
    }
}
