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
    /// Creates a date formatter that uses the `en_US_POSIX` locale.
    ///
    /// Use this for fixed-format strings that must not change with the user's locale.
    ///
    /// - Parameter format: A date format string, such as `"dd-MM-yyyy"`.
    /// - Returns: A new formatter. Create one per use rather than sharing it.
    static func posix(_ format: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = format
        return formatter
    }
}

public extension Date {

    /// Returns the date formatted as `dd-MM-yyyy` in the current time zone.
    ///
    /// ```swift
    /// Date.now.toString()   // "27-10-2026"
    /// ```
    ///
    /// - Returns: The formatted date.
    func toString() -> String {
        formatted(Date.dayStyle)
    }

    /// Returns the time formatted as 24-hour `HH:mm` in the current time zone.
    ///
    /// ```swift
    /// Date.now.toTimeString()   // "09:45"
    /// ```
    ///
    /// - Returns: The formatted time.
    func toTimeString() -> String {
        formatted(Date.timeStyle)
    }

    /// Returns a Boolean value that indicates whether the date falls on the same calendar day as another date.
    ///
    /// - Parameters:
    ///   - other: The date to compare with.
    ///   - calendar: The calendar that defines day boundaries. The default is the current calendar.
    /// - Returns: `true` if both dates fall on the same calendar day.
    func isSameDay(as other: Date, calendar: Calendar = .current) -> Bool {
        calendar.isDate(self, inSameDayAs: other)
    }

    /// A Boolean value that indicates whether the date falls on today's calendar day.
    var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }

    /// The first moment of the calendar day that contains the date.
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }

    /// Returns the date moved by a number of calendar units.
    ///
    /// ```swift
    /// let nextWeek = Date.now.adding(.day, value: 7)
    /// ```
    ///
    /// - Parameters:
    ///   - component: The calendar unit to add, such as `.day` or `.month`.
    ///   - value: The number of units to add. A negative value moves the date backward.
    ///   - calendar: The calendar used for the calculation. The default is the current calendar.
    /// - Returns: The new date, or `nil` if the result is outside the range the calendar supports.
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
