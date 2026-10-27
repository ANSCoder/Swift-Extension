//  AuroraGradientDemo.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI
import SwiftExtension

struct AuroraGradientDemo: View {
    let play: Int
    @State private var paletteIndex = 0
    private let palettes = [
        ["6366F1", "EC4899", "14B8A6"],
        ["F59E0B", "EF4444", "8B5CF6"],
        ["22D3EE", "3B82F6", "A3E635"]
    ]

    static let info = ExampleInfo(
        category: .animations,
        title: "Aurora gradient",
        summary: "Three blurred circles drift on sine paths over a dark base. Palette changes cross-fade.",
        code: #"""
        TimelineView(.animation) { timeline in
            let t = timeline.date.timeIntervalSinceReferenceDate
            ZStack {
                Color(hex: "0B1020")
                ForEach(0..<3, id: \.self) { index in
                    Circle()
                        .fill(colors[index])
                        .frame(width: 190, height: 190)
                        .offset(x: cos(t * 0.6 + Double(index) * 2.1) * 80,
                                y: sin(t * 0.5 + Double(index) * 1.7) * 60)
                        .blur(radius: 48)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 24))
        }
        """#
    )

    var body: some View {
        TimelineView(.animation) { timeline in
            let t = timeline.date.timeIntervalSinceReferenceDate
            ZStack {
                Color(hex: "0B1020")
                ForEach(0..<3, id: \.self) { index in
                    Circle()
                        .fill(Color(hex: palettes[paletteIndex][index]))
                        .frame(width: 190, height: 190)
                        .offset(x: cos(t * 0.6 + Double(index) * 2.1) * 80, y: sin(t * 0.5 + Double(index) * 1.7) * 60)
                        .blur(radius: 48)
                }
                VStack(spacing: 4) {
                    Text("Aurora").font(.title.bold())
                    Text("Animated gradient").font(.subheadline)
                }
                .foregroundStyle(.white)
                .shadow(color: .black.opacity(0.45), radius: 6)
            }
            .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        }
        .frame(width: 300, height: 240)
        .animation(.smooth(duration: 1.2), value: paletteIndex)
        .accessibilityLabel("Animated aurora gradient")
        .onChange(of: play) { _, _ in
            paletteIndex = (paletteIndex + 1) % palettes.count
        }
    }
}
