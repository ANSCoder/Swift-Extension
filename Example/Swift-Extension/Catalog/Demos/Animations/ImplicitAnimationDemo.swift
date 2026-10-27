//  ImplicitAnimationDemo.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI

struct ImplicitAnimationDemo: View {
    let play: Int
    @State private var on = false

    static let info = ExampleInfo(
        category: .animations,
        title: "Implicit animation",
        summary: "animation(_:value:) animates any change to the value without withAnimation.",
        code: #"""
        @State private var on = false

        RoundedRectangle(cornerRadius: on ? 70 : 12)
            .fill(on ? .pink : .teal)
            .frame(width: 140, height: 140)
            .rotationEffect(.degrees(on ? 90 : 0))
            .animation(.easeInOut(duration: 0.6), value: on)
        """#
    )

    var body: some View {
        VStack(spacing: 24) {
            RoundedRectangle(cornerRadius: on ? 70 : 12)
                .fill(on ? .pink : .teal)
                .frame(width: 140, height: 140)
                .rotationEffect(.degrees(on ? 90 : 0))
                .animation(.easeInOut(duration: 0.6), value: on)
            Toggle("Morph", isOn: $on)
        }
        .onChange(of: play) { _, _ in on.toggle() }
    }
}
