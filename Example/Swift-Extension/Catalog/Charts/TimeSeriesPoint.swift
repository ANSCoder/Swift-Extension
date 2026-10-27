//  TimeSeriesPoint.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import Foundation
import SwiftExtension

/// A value on a date, used by the line and scrollable charts.
struct TimeSeriesPoint: Identifiable {
    let date: Date
    let value: Double

    var id: Date { date }

    /// `days` daily points ending today, shaped like a trending, slightly noisy metric.
    static func series(days: Int, seed: Int = 0) -> [TimeSeriesPoint] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: .now)
        return (0..<days).compactMap { offset in
            guard let date = calendar.date(byAdding: .day, value: offset - days + 1, to: today) else { return nil }
            let step = Double(offset)
            let trend = 60 + step * 0.35
            let wave = 18 * sin(step / 5 + Double(seed)) + 8 * sin(step / 1.7 + Double(seed) * 2)
            return TimeSeriesPoint(date: date, value: max(5, trend + wave))
        }
    }
}
