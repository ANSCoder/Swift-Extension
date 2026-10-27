//  LiquidWaveDemo.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI
import SwiftExtension

struct LiquidWaveDemo: View {
    let play: Int
    @State private var level = 0.55
    private let diameter: CGFloat = 210

    static let info = ExampleInfo(
        category: .animations,
        title: "Liquid wave gauge",
        summary: "A custom Shape with animatable phase. Two offset waves inside a circle make a water level gauge.",
        code: #"""
        struct WaveShape: Shape {
            var phase: Double
            var amplitude: CGFloat = 8
            var animatableData: Double { get { phase } set { phase = newValue } }

            func path(in rect: CGRect) -> Path {
                var path = Path()
                path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
                for x in stride(from: 0, through: rect.width, by: 3) {
                    let wave = sin(Double(x / rect.width) * 3 * .pi + phase)
                    path.addLine(to: CGPoint(x: x, y: amplitude + CGFloat(wave) * amplitude))
                }
                path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
                return path
            }
        }

        TimelineView(.animation) { timeline in
            let t = timeline.date.timeIntervalSinceReferenceDate
            WaveShape(phase: t * 2.2).fill(.blue.opacity(0.55))
        }
        """#
    )

    var body: some View {
        ZStack {
            TimelineView(.animation) { timeline in
                let t = timeline.date.timeIntervalSinceReferenceDate
                ZStack(alignment: .bottom) {
                    WaveShape(phase: t * 2.2, amplitude: 9)
                        .fill(Palette.series[4].opacity(0.55))
                        .frame(height: diameter * level + 18)
                    WaveShape(phase: t * 1.6 + 2, amplitude: 7)
                        .fill(Color(hex: "2563EB").opacity(0.75))
                        .frame(height: diameter * level + 14)
                }
                .frame(width: diameter, height: diameter, alignment: .bottom)
                .animation(.smooth(duration: 0.9), value: level)
            }
            .clipShape(Circle())
            .overlay { Circle().strokeBorder(Palette.stroke, lineWidth: 4) }

            Text(level, format: .percent.precision(.fractionLength(0)))
                .font(.system(.largeTitle, design: .rounded).bold().monospacedDigit())
                .foregroundStyle(level > 0.5 ? Color.white : Color.primary)
                .contentTransition(.numericText(value: level))
                .animation(.smooth, value: level)
        }
        .frame(width: diameter, height: diameter)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Water level")
        .accessibilityValue("\(Int(level * 100)) percent")
        .onChange(of: play) { _, _ in
            level = Double.random(in: 0.15...0.92)
        }
    }
}
