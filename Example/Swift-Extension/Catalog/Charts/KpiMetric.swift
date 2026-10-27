//  KpiMetric.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import Foundation

/// A headline number with its change and a small trend line.
struct KpiMetric: Identifiable {
    let title: String
    let value: String
    /// Change versus the previous period, in percent.
    let delta: Double
    let trend: [Double]

    var id: String { title }

    static func samples(seed: Int = 0) -> [KpiMetric] {
        func trend(_ salt: Int) -> [Double] {
            (0..<14).map { index in
                50 + Double(index) * 1.6 + 10 * sin(Double(index) / 2 + Double(salt + seed))
            }
        }
        let shift = Double(seed % 5)
        return [
            KpiMetric(title: "Revenue", value: String(format: "$%.1fK", 48.2 + shift * 1.7), delta: 4.2 + shift, trend: trend(1)),
            KpiMetric(title: "Active users", value: String(format: "%.1fK", 12.5 + shift * 0.4), delta: 8.9 - shift, trend: trend(2)),
            KpiMetric(title: "Churn", value: String(format: "%.1f%%", 2.4 + shift * 0.1), delta: -1.3 - shift * 0.4, trend: trend(3))
        ]
    }
}
