//  RadarPulseDemo.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI
import SwiftExtension

struct RadarPulseDemo: View {
    let play: Int
    @State private var paused = false

    static let info = ExampleInfo(
        category: .animations,
        title: "Radar pulse",
        summary: "Three rings offset in phase scale up and fade out. Pure math on TimelineView time, no state.",
        code: #"""
        TimelineView(.animation(paused: paused)) { timeline in
            let t = timeline.date.timeIntervalSinceReferenceDate
            ZStack {
                ForEach(0..<3, id: \.self) { index in
                    let phase = ((t / 2.4) + Double(index) / 3).truncatingRemainder(dividingBy: 1)
                    Circle()
                        .strokeBorder(.teal, lineWidth: 3)
                        .scaleEffect(0.15 + phase * 0.85)
                        .opacity(1 - phase)
                }
                Image(systemName: "dot.radiowaves.left.and.right")
            }
        }
        """#
    )

    var body: some View {
        TimelineView(.animation(paused: paused)) { timeline in
            let t = timeline.date.timeIntervalSinceReferenceDate
            ZStack {
                ForEach(0..<3, id: \.self) { index in
                    let phase = ((t / 2.4) + Double(index) / 3).truncatingRemainder(dividingBy: 1)
                    Circle()
                        .strokeBorder(Color(hex: "0D9488"), lineWidth: 3)
                        .scaleEffect(0.15 + phase * 0.85)
                        .opacity(1 - phase)
                }
                Image(systemName: "dot.radiowaves.left.and.right")
                    .font(.title2.weight(.semibold))
                    .foregroundStyle(.white)
                    .frame(width: 58, height: 58)
                    .background(Color(hex: "0D9488"), in: Circle())
            }
            .frame(width: 250, height: 250)
        }
        .onChange(of: play) { _, _ in paused.toggle() }
    }
}
