//  SizeAndAppearDemo.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI
import SwiftExtension

struct SizeAndAppearDemo: View {
    let play: Int
    @State private var width: CGFloat = 220
    @State private var measured = CGSize.zero
    @State private var appearances = 0

    static let info = ExampleInfo(
        category: .modifiers,
        title: "Size & first appear",
        summary: "onSizeChange reports rendered size. onFirstAppear runs once, even when the view re-appears.",
        code: #"""
        @State private var measured = CGSize.zero
        @State private var appearances = 0

        RoundedRectangle(cornerRadius: 12)
            .frame(width: width, height: 60)
            .onSizeChange { measured = $0 }
            .onFirstAppear { appearances += 1 }
        """#
    )

    var body: some View {
        VStack(spacing: 14) {
            RoundedRectangle(cornerRadius: 12)
                .fill(.teal.gradient)
                .frame(width: width, height: 60)
                .onSizeChange { measured = $0 }

            Text("Measured: \(Int(measured.width)) × \(Int(measured.height))")
                .font(.footnote.monospacedDigit())

            Slider(value: $width, in: 120...300)

            Text("First appear fired \(appearances) time(s)")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
        .onFirstAppear { appearances += 1 }
        .onChange(of: play) { _, _ in
            withAnimation(.smooth) { width = width > 200 ? 120 : 280 }
        }
    }
}
