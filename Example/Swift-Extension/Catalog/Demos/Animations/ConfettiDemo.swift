//  ConfettiDemo.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI

struct ConfettiDemo: View {
    let play: Int
    @State private var startDate: Date?
    private let particles = ConfettiParticle.burst(count: 90)
    private let duration = 2.6

    static let info = ExampleInfo(
        category: .animations,
        title: "Confetti burst",
        summary: "A Canvas inside TimelineView draws 90 particles from a physics formula. No per-particle views.",
        code: #"""
        TimelineView(.animation(paused: startDate == nil)) { timeline in
            Canvas { context, size in
                guard let start = startDate else { return }
                let t = timeline.date.timeIntervalSince(start)
                for p in particles {
                    let x = origin.x + cos(p.angle) * p.speed * t
                    let y = origin.y + sin(p.angle) * p.speed * t + 0.5 * 520 * t * t   // gravity
                    var layer = context
                    layer.opacity = max(0, 1 - t / duration)
                    layer.translateBy(x: x, y: y)
                    layer.rotate(by: .radians(p.spin * t))
                    layer.fill(Path(roundedRect: rect, cornerRadius: 1.5), with: .color(color))
                }
            }
        }
        """#
    )

    var body: some View {
        let start = startDate
        let particles = particles
        let duration = duration
        return ZStack {
            Image(systemName: "party.popper.fill")
                .font(.system(size: 54))
                .foregroundStyle(Palette.series[2])
                .offset(y: 70)
            TimelineView(.animation(paused: start == nil)) { timeline in
                Canvas { context, size in
                    guard let start else { return }
                    let t = timeline.date.timeIntervalSince(start)
                    guard t >= 0, t < duration else { return }
                    let origin = CGPoint(x: size.width / 2, y: size.height * 0.72)
                    for particle in particles {
                        let x = origin.x + cos(particle.angle) * particle.speed * t
                        let y = origin.y + sin(particle.angle) * particle.speed * t + 0.5 * 520 * t * t
                        var layer = context
                        layer.opacity = max(0, 1 - t / duration)
                        layer.translateBy(x: x, y: y)
                        layer.rotate(by: .radians(particle.spin * t))
                        let rect = CGRect(x: -particle.size / 2, y: -particle.size / 4, width: particle.size, height: particle.size / 2)
                        layer.fill(Path(roundedRect: rect, cornerRadius: 1.5), with: .color(Palette.series[particle.colorIndex]))
                    }
                }
            }
            .allowsHitTesting(false)
            .accessibilityHidden(true)
        }
        .onChange(of: play) { _, _ in startDate = .now }
    }
}
