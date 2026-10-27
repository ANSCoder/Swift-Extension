//  SymbolEffectDemo.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI

struct SymbolEffectDemo: View {
    let play: Int
    @State private var waving = false

    static let info = ExampleInfo(
        category: .animations,
        title: "SF Symbol effects",
        summary: "symbolEffect (iOS 17) bounces, pulses or cycles colors. Triggered by value or kept running with isActive.",
        code: #"""
        @State private var waving = false

        Image(systemName: "heart.fill")
            .symbolEffect(.bounce, value: play)

        Image(systemName: "wifi")
            .symbolEffect(.variableColor.iterative, options: .repeating, isActive: waving)

        Image(systemName: "bell.fill")
            .symbolEffect(.pulse, options: .repeating)
        """#
    )

    var body: some View {
        VStack(spacing: 24) {
            HStack(spacing: 36) {
                Image(systemName: "heart.fill")
                    .font(.largeTitle)
                    .foregroundStyle(.red)
                    .symbolEffect(.bounce, value: play)
                Image(systemName: "wifi")
                    .font(.largeTitle)
                    .symbolEffect(.variableColor.iterative, options: .repeating, isActive: waving)
                Image(systemName: "bell.fill")
                    .font(.largeTitle)
                    .symbolEffect(.pulse, options: .repeating)
            }
            Toggle("Wi-Fi animates", isOn: $waving)
                .font(.footnote)
        }
        .onChange(of: play) { _, _ in waving.toggle() }
    }
}
