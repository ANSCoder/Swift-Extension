//  TransitionsDemo.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI

struct TransitionsDemo: View {
    let play: Int
    @State private var shown = true
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    static let info = ExampleInfo(
        category: .animations,
        title: "Transitions",
        summary: "Insert and remove effects with asymmetric(insertion:removal:). Pair with withAnimation.",
        code: #"""
        @State private var shown = true

        ZStack {
            if shown {
                RoundedRectangle(cornerRadius: 16)
                    .transition(.asymmetric(
                        insertion: .move(edge: .leading).combined(with: .opacity),
                        removal: .scale.combined(with: .opacity)
                    ))
            }
        }
        Button("Show / hide") {
            withAnimation(.smooth) { shown.toggle() }
        }
        """#
    )

    var body: some View {
        VStack(spacing: 20) {
            ZStack {
                if shown {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.indigo.gradient)
                        .frame(width: 200, height: 110)
                        .overlay { Text("Card").font(.headline).foregroundStyle(.white) }
                        .transition(.asymmetric(
                            insertion: .move(edge: .leading).combined(with: .opacity),
                            removal: .scale.combined(with: .opacity)
                        ))
                }
            }
            .frame(height: 120)

            Button("Show / hide") { toggle() }
                .buttonStyle(.bordered)
        }
        .onChange(of: play) { _, _ in toggle() }
    }

    private func toggle() {
        withAnimation(reduceMotion ? nil : .smooth) { shown.toggle() }
    }
}
