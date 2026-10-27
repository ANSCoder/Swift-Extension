//
//  ExDate.swift
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

public extension DateFormatter {
    /// A formatter pinned to `en_US_POSIX` so digits and month names never depend on the user's locale.
    /// Internal: only used for parsing and one-off formatting, never shared between threads.
    static func posix(_ format: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = format
        return formatter
    }
}

public extension Date {

    /// The date as `dd-MM-yyyy`, e.g. `27-10-2026`, in the current time zone.
    ///
    /// Uses a value-type `FormatStyle`, so there is no shared formatter and no locking.
    func toString() -> String {
        formatted(Date.dayStyle)
    }

    /// The time as `HH:mm`, e.g. `09:45`, in the current time zone.
    func toTimeString() -> String {
        formatted(Date.timeStyle)
    }

    /// `true` when the date falls on the same calendar day as `other`.
    ///
    /// ```swift
    /// morning.isSameDay(as: evening)   // true
    /// ```
    func isSameDay(as other: Date, calendar: Calendar = .current) -> Bool {
        calendar.isDate(self, inSameDayAs: other)
    }

    /// `true` when the date falls on today.
    var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }

    /// The first moment of the calendar day containing the date.
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }

    /// The date moved by `value` units of `component`. Returns `nil` when the result cannot be calculated.
    ///
    /// ```swift
    /// Date.now.adding(.day, value: 7)
    /// ```
    func adding(_ component: Calendar.Component, value: Int, calendar: Calendar = .current) -> Date? {
        calendar.date(byAdding: component, value: value, to: self)
    }
}

private extension Date {
    static var dayStyle: Date.VerbatimFormatStyle {
        Date.VerbatimFormatStyle(
            format: "\(day: .twoDigits)-\(month: .twoDigits)-\(year: .padded(4))",
            locale: Locale(identifier: "en_US_POSIX"),
            timeZone: .current,
            calendar: Calendar(identifier: .gregorian)
        )
    }

    static var timeStyle: Date.VerbatimFormatStyle {
        Date.VerbatimFormatStyle(
            format: "\(hour: .twoDigits(clock: .twentyFourHour, hourCycle: .zeroBased)):\(minute: .twoDigits)",
            locale: Locale(identifier: "en_US_POSIX"),
            timeZone: .current,
            calendar: Calendar(identifier: .gregorian)
        )
    }
}
