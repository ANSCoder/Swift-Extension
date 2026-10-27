//  TimelineViewDemo.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI

struct TimelineViewDemo: View {
    let play: Int
    @State private var paused = false

    static let info = ExampleInfo(
        category: .animations,
        title: "Timeline-driven animation",
        summary: "TimelineView redraws every frame with the current date. Use for clocks, rotations and custom physics.",
        code: #"""
            @State private var paused = false

            TimelineView(.animation(paused: paused)) { context in
                let seconds = context.date.timeIntervalSinceReferenceDate
                Image(systemName: "gear")
                    .font(.system(size: 64))
                    .rotationEffect(.degrees(seconds.truncatingRemainder(dividingBy: 4) * 90))
            }
            """#
    )

    var body: some View {
        VStack(spacing: 16) {
            TimelineView(.animation(paused: paused)) { context in
                let seconds = context.date.timeIntervalSinceReferenceDate
                Image(systemName: "gear")
                    .font(.system(size: 64))
                    .foregroundStyle(.gray)
                    .rotationEffect(.degrees(seconds.truncatingRemainder(dividingBy: 4) * 90))
            }
            Toggle("Pause", isOn: $paused)
                .font(.footnote)
        }
        .onChange(of: play) { _, _ in paused.toggle() }
    }
}
