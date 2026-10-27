//  ChartDatum+Samples.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import Foundation

/// Deterministic sample data. `seed` changes the numbers so Play can show a data update.
extension ChartDatum {
    /// Revenue per weekday, in thousands of dollars.
    static func weekly(seed: Int = 0) -> [ChartDatum] {
        ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"].enumerated().map { index, day in
            ChartDatum(label: day, value: (20 + noise(index, seed) * 60).rounded())
        }
    }

    /// Share of visits by traffic source.
    static func marketShare(seed: Int = 0) -> [ChartDatum] {
        ["Direct", "Search", "Social", "Referral", "Email"].enumerated().map { index, source in
            ChartDatum(label: source, value: (10 + noise(index + 11, seed) * 50).rounded())
        }
    }

    /// Sessions per month split by platform.
    static func monthlyChannels(seed: Int = 0) -> [ChartDatum] {
        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
        let channels = ["Web", "iOS", "Android"]
        return months.enumerated().flatMap { monthIndex, month in
            channels.enumerated().map { channelIndex, channel in
                ChartDatum(
                    label: month,
                    value: (30 + noise(monthIndex * 3 + channelIndex, seed) * 70).rounded(),
                    series: channel
                )
            }
        }
    }

    /// A repeatable value in 0...1 for an index and seed.
    private static func noise(_ index: Int, _ seed: Int) -> Double {
        let raw = sin(Double(index + 1) * 12.9898 + Double(seed) * 78.233) * 43_758.5453
        return raw - raw.rounded(.down)
    }
}
