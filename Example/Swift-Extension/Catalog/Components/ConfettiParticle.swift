//  ConfettiParticle.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import Foundation

/// One confetti piece. Motion is computed from time, so no per-frame state is stored.
struct ConfettiParticle: Identifiable {
    let id: Int
    /// Launch direction in radians. Zero points right, negative values point up.
    let angle: Double
    let speed: Double
    let spin: Double
    let size: Double
    let colorIndex: Int

    /// A deterministic burst fanning upward.
    static func burst(count: Int) -> [ConfettiParticle] {
        (0..<count).map { index in
            ConfettiParticle(
                id: index,
                angle: -Double.pi / 2 + (unit(index, 1) - 0.5) * Double.pi * 1.1,
                speed: 190 + unit(index, 2) * 270,
                spin: (unit(index, 3) - 0.5) * 14,
                size: 6 + unit(index, 4) * 6,
                colorIndex: index % 5
            )
        }
    }

    private static func unit(_ index: Int, _ salt: Double) -> Double {
        let raw = sin(Double(index) * 12.9898 + salt * 78.233) * 43_758.5453
        return raw - raw.rounded(.down)
    }
}
