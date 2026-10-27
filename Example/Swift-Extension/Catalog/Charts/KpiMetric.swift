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
        let shift: Double = Double(seed % 5)
        return [
            KpiMetric(
                title: "Revenue",
                value: formatted(48.2 + shift * 1.7, "$%.1fK"),
                delta: 4.2 + shift,
                trend: trend(salt: 1, seed: seed)
            ),
            KpiMetric(
                title: "Active users",
                value: formatted(12.5 + shift * 0.4, "%.1fK"),
                delta: 8.9 - shift,
                trend: trend(salt: 2, seed: seed)
            ),
            KpiMetric(
                title: "Churn",
                value: formatted(2.4 + shift * 0.1, "%.1f%%"),
                delta: -1.3 - shift * 0.4,
                trend: trend(salt: 3, seed: seed)
            ),
        ]
    }

    /// A gently rising 14-point series with a wave whose phase depends on `salt` and `seed`.
    private static func trend(salt: Int, seed: Int) -> [Double] {
        let phase: Double = Double(salt + seed)
        return (0..<14).map { (index: Int) -> Double in
            let base: Double = 50 + Double(index) * 1.6
            let wave: Double = 10 * sin(Double(index) / 2 + phase)
            return base + wave
        }
    }

    private static func formatted(_ value: Double, _ format: String) -> String {
        String(format: format, value)
    }
}
