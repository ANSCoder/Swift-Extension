//  ProgressRingDemo.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI
import SwiftExtension

struct ProgressRingDemo: View {
    let play: Int
    @State private var progress = 0.72

    static let info = ExampleInfo(
        category: .animations,
        title: "Progress ring",
        summary: "A trimmed circle with an angular gradient and a numeric transition in the middle. Springs to each new value.",
        code: #"""
            @State private var progress = 0.72

            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    AngularGradient(colors: [.indigo, .pink], center: .center),
                    style: StrokeStyle(lineWidth: 18, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))

            Text(progress, format: .percent.precision(.fractionLength(0)))
                .contentTransition(.numericText(value: progress))

            Button("Update") {
                withAnimation(.spring(duration: 1, bounce: 0.25)) { progress = .random(in: 0.2...1) }
            }
            """#
    )

    var body: some View {
        ZStack {
            Circle()
                .stroke(Palette.stroke, lineWidth: 18)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    AngularGradient(
                        colors: [Palette.series[0], Palette.series[3]], center: .center, startAngle: .degrees(0), endAngle: .degrees(360)),
                    style: StrokeStyle(lineWidth: 18, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
            VStack(spacing: 2) {
                Text(progress, format: .percent.precision(.fractionLength(0)))
                    .font(.system(.largeTitle, design: .rounded).bold().monospacedDigit())
                    .contentTransition(.numericText(value: progress))
                Text("Daily goal")
                    .font(.caption)
                    .foregroundStyle(Palette.secondaryText)
            }
        }
        .frame(width: 200, height: 200)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Daily goal")
        .accessibilityValue("\(Int(progress * 100)) percent")
        .onChange(of: play) { _, _ in
            withAnimation(.spring(duration: 1, bounce: 0.25)) {
                progress = Double.random(in: 0.2...1)
            }
        }
    }
}
