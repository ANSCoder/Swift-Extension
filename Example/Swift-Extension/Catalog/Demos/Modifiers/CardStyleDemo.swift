//  CardStyleDemo.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI
import SwiftExtension

struct CardStyleDemo: View {
    let play: Int
    @State private var radius: CGFloat = 12

    static let info = ExampleInfo(
        category: .modifiers,
        title: "Card style & rounded border",
        summary: "cardStyle(cornerRadius:) adds padding, background and shadow. roundedBorder adds a stroke.",
        code: #"""
            Text("Card title")
                .frame(maxWidth: .infinity, alignment: .leading)
                .cardStyle(cornerRadius: 12)
                .roundedBorder(.secondary.opacity(0.4), cornerRadius: 12)
            """#
    )

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Card title")
                .font(.headline)
            Text("cardStyle() adds padding, background and shadow. roundedBorder() adds a stroke.")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .cardStyle(cornerRadius: radius)
        .roundedBorder(.secondary.opacity(0.4), cornerRadius: radius)
        .padding()
        .onChange(of: play) { _, _ in
            withAnimation(.smooth) { radius = radius == 12 ? 28 : 12 }
        }
    }
}
