//  Palette.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI
import UIKit
import SwiftExtension

/// Brand and semantic colors for the catalog app.
///
/// Every color adapts to light and dark mode. Text colors meet WCAG AA (4.5:1) on the
/// surfaces they are used with, and chart `series` colors stay distinguishable in both modes.
enum Palette {
    static let background = adaptive(light: "F4F5FA", dark: "0B0D14")
    static let surface = adaptive(light: "FFFFFF", dark: "151824")
    static let stroke = adaptive(light: "E3E6F0", dark: "262B3D")
    static let secondaryText = adaptive(light: "566074", dark: "A0A8BD")
    static let accent = adaptive(light: "4F46E5", dark: "8B8CFF")
    static let positive = adaptive(light: "047857", dark: "34D399")
    static let negative = adaptive(light: "B91C1C", dark: "F87171")

    /// Indigo to violet. White text on it passes 4.5:1.
    static let brandGradient = LinearGradient(
        colors: [Color(hex: "4F46E5"), Color(hex: "7C3AED")],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    /// Categorical colors for chart series, in order of use.
    static let series: [Color] = ["6366F1", "14B8A6", "F59E0B", "EC4899", "38BDF8"].map { Color(hex: $0) }

    private static func adaptive(light: String, dark: String) -> Color {
        Color(uiColor: UIColor { traits in
            traits.userInterfaceStyle == .dark ? UIColor(hex: dark) : UIColor(hex: light)
        })
    }
}
