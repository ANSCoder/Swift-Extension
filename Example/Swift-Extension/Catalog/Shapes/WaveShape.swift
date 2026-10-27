//  WaveShape.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI

/// The area under a sine wave. Animate `phase` to make the surface move.
struct WaveShape: Shape {
    var phase: Double
    var amplitude: CGFloat = 8
    var frequency: Double = 1.5

    var animatableData: Double {
        get { phase }
        set { phase = newValue }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        for x in stride(from: CGFloat(0), through: rect.width, by: 3) {
            let relative = Double(x / max(rect.width, 1))
            let wave = CGFloat(sin(relative * frequency * 2 * .pi + phase))
            path.addLine(to: CGPoint(x: rect.minX + x, y: rect.minY + amplitude + wave * amplitude))
        }
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}
