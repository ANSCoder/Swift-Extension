//  NumberHelpersDemo.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI
import SwiftExtension

struct NumberHelpersDemo: View {
    let play: Int
    @State private var value: Double = 4.256

    static let info = ExampleInfo(
        category: .foundation,
        title: "Clamp & round numbers",
        summary: "clamped(to:) limits any Comparable to a range. rounded(toPlaces:) trims decimals.",
        code: #"""
        15.clamped(to: 0...10)        // 10
        (-3.0).clamped(to: 0...10)    // 0
        3.14159.rounded(toPlaces: 2)  // 3.14
        """#
    )

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Slider(value: $value, in: 0...10)
            Text("Raw: \(value, format: .number.precision(.fractionLength(3)))")
            Text("Rounded to 1 place: \(value.rounded(toPlaces: 1), format: .number)")
            Text("Clamped to 0...5: \((value * 1.5).clamped(to: 0...5), format: .number.precision(.fractionLength(2)))")
        }
        .font(.footnote.monospacedDigit())
        .frame(maxWidth: .infinity, alignment: .leading)
        .onChange(of: play) { _, _ in
            withAnimation { value = Double.random(in: 0...10) }
        }
    }
}
