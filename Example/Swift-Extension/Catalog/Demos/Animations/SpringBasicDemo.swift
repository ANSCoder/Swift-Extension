//  SpringBasicDemo.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI

struct SpringBasicDemo: View {
    let play: Int
    @State private var big = false
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    static let info = ExampleInfo(
        category: .animations,
        title: "Spring basics",
        summary: "withAnimation + spring(response:dampingFraction:). Lower damping = more bounce. Honors Reduce Motion.",
        code: #"""
            @State private var big = false
            @Environment(\.accessibilityReduceMotion) private var reduceMotion

            Circle()
                .scaleEffect(big ? 1.6 : 1)
                .onTapGesture {
                    withAnimation(reduceMotion ? nil : .spring(response: 0.4, dampingFraction: 0.5)) {
                        big.toggle()
                    }
                }
            """#
    )

    var body: some View {
        VStack(spacing: 24) {
            Circle()
                .fill(.orange.gradient)
                .frame(width: 90, height: 90)
                .scaleEffect(big ? 1.6 : 1)
            Button("Spring") { bounce() }
                .buttonStyle(.bordered)
        }
        .onChange(of: play) { _, _ in bounce() }
    }

    private func bounce() {
        withAnimation(reduceMotion ? nil : .spring(response: 0.4, dampingFraction: 0.5)) {
            big.toggle()
        }
    }
}
