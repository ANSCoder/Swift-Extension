//  StageBackground.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI

/// Tinted wash with a dot grid. Gives every demo the same "stage" to play on.
struct StageBackground: View {
    let tint: Color

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [tint.opacity(0.16), tint.opacity(0.04)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            Canvas { context, size in
                let spacing: CGFloat = 18
                for x in stride(from: spacing / 2, to: size.width, by: spacing) {
                    for y in stride(from: spacing / 2, to: size.height, by: spacing) {
                        context.fill(
                            Path(ellipseIn: CGRect(x: x - 1, y: y - 1, width: 2, height: 2)),
                            with: .color(tint.opacity(0.22))
                        )
                    }
                }
            }
        }
        .accessibilityHidden(true)
    }
}
