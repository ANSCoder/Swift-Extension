//  AdaptiveGridDemo.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI

struct AdaptiveGridDemo: View {
    let play: Int
    @State private var minimum: CGFloat = 70

    static let info = ExampleInfo(
        category: .stacks,
        title: "Adaptive grid",
        summary: "LazyVGrid with .adaptive columns fits as many cells as the width allows. Scales to iPad.",
        code: #"""
            @State private var minimum: CGFloat = 70

            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: minimum), spacing: 8)], spacing: 8) {
                    ForEach(0..<30, id: \.self) { index in
                        Circle().fill(.tint.opacity(0.4))
                            .aspectRatio(1, contentMode: .fit)
                    }
                }
            }
            """#
    )

    var body: some View {
        VStack(spacing: 10) {
            Text("Minimum cell: \(Int(minimum)) pt")
                .font(.footnote.monospacedDigit())
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: minimum), spacing: 8)], spacing: 8) {
                    ForEach(0..<30, id: \.self) { index in
                        Text("\(index)")
                            .frame(maxWidth: .infinity)
                            .aspectRatio(1, contentMode: .fit)
                            .background(.tint.opacity(0.25), in: RoundedRectangle(cornerRadius: 10))
                    }
                }
            }
        }
        .onChange(of: play) { _, _ in
            withAnimation(.smooth) { minimum = minimum >= 110 ? 50 : minimum + 20 }
        }
    }
}
