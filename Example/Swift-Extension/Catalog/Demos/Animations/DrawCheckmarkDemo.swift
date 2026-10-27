//  DrawCheckmarkDemo.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI
import SwiftExtension

struct DrawCheckmarkDemo: View {
    let play: Int
    @State private var ring: CGFloat = 1
    @State private var check: CGFloat = 1

    static let info = ExampleInfo(
        category: .animations,
        title: "Draw-on checkmark",
        summary: "trim(from:to:) on a Shape draws a stroke on over time. Ring first, then the check, like a success state.",
        code: #"""
        struct CheckmarkShape: Shape {
            func path(in rect: CGRect) -> Path {
                var path = Path()
                path.move(to: CGPoint(x: rect.width * 0.20, y: rect.height * 0.52))
                path.addLine(to: CGPoint(x: rect.width * 0.42, y: rect.height * 0.74))
                path.addLine(to: CGPoint(x: rect.width * 0.80, y: rect.height * 0.30))
                return path
            }
        }

        Circle().trim(from: 0, to: ring)
            .stroke(.green, style: StrokeStyle(lineWidth: 10, lineCap: .round))
            .rotationEffect(.degrees(-90))
        CheckmarkShape().trim(from: 0, to: check)
            .stroke(.green, style: StrokeStyle(lineWidth: 12, lineCap: .round, lineJoin: .round))
        """#
    )

    var body: some View {
        ZStack {
            Circle()
                .stroke(Palette.stroke, lineWidth: 10)
            Circle()
                .trim(from: 0, to: ring)
                .stroke(Color(hex: "10B981"), style: StrokeStyle(lineWidth: 10, lineCap: .round))
                .rotationEffect(.degrees(-90))
            CheckmarkShape()
                .trim(from: 0, to: check)
                .stroke(Color(hex: "10B981"), style: StrokeStyle(lineWidth: 12, lineCap: .round, lineJoin: .round))
                .padding(46)
        }
        .frame(width: 170, height: 170)
        .accessibilityLabel("Success")
        .task(id: play) {
            guard play > 0 else { return }
            ring = 0
            check = 0
            try? await Task.sleep(for: .milliseconds(40))
            guard !Task.isCancelled else { return }
            withAnimation(.easeInOut(duration: 0.7)) { ring = 1 }
            try? await Task.sleep(for: .milliseconds(650))
            guard !Task.isCancelled else { return }
            withAnimation(.easeOut(duration: 0.45)) { check = 1 }
        }
    }
}
