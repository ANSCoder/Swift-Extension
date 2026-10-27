//  NumericTextDemo.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI

struct NumericTextDemo: View {
    let play: Int
    @State private var count = 0

    static let info = ExampleInfo(
        category: .text,
        title: "Numeric text transition",
        summary: "contentTransition(.numericText(value:)) rolls digits up or down as the value changes (iOS 17).",
        code: #"""
        @State private var count = 0

        Text("\(count)")
            .font(.system(size: 56, weight: .bold, design: .rounded))
            .monospacedDigit()
            .contentTransition(.numericText(value: Double(count)))

        Button("+1") { withAnimation { count += 1 } }
        """#
    )

    var body: some View {
        VStack(spacing: 16) {
            Text("\(count)")
                .font(.system(size: 56, weight: .bold, design: .rounded))
                .monospacedDigit()
                .contentTransition(.numericText(value: Double(count)))

            HStack {
                Button("−1") { withAnimation { count -= 1 } }
                Button("+1") { withAnimation { count += 1 } }
            }
            .buttonStyle(.bordered)
        }
        .onChange(of: play) { _, _ in
            withAnimation { count += 1 }
        }
    }
}
