//  ShakeDemo.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI
import SwiftExtension

struct ShakeDemo: View {
    let play: Int

    static let info = ExampleInfo(
        category: .animations,
        title: "Shake on error",
        summary: "shake(trigger:) wobbles a view when a value changes. Skipped when Reduce Motion is on.",
        code: #"""
            @State private var attempts = 0

            Text("Wrong password")
                .padding()
                .roundedBorder(.red, cornerRadius: 10)
                .shake(trigger: attempts)
            """#
    )

    var body: some View {
        VStack(spacing: 16) {
            Text("Wrong password")
                .padding()
                .frame(maxWidth: .infinity)
                .roundedBorder(.red, cornerRadius: 10)
                .shake(trigger: play)
            Text("Each Play shakes the field. Skipped when Reduce Motion is on.")
                .font(.footnote)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }
}
