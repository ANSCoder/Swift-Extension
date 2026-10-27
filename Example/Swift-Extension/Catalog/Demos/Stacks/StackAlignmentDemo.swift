//  StackAlignmentDemo.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI

struct StackAlignmentDemo: View {
    let play: Int
    @State private var trailing = false

    static let info = ExampleInfo(
        category: .stacks,
        title: "Stack alignment & overlays",
        summary: "VStack/HStack/ZStack alignment, spacing and overlays. The base of every layout.",
        code: #"""
            @State private var trailing = false

            VStack(alignment: trailing ? .trailing : .leading, spacing: 8) {
                Text("Title").font(.headline)
                Text("Subtitle").font(.subheadline)
                HStack { Text("Left"); Spacer(); Text("Right") }
            }
            .overlay(alignment: .topTrailing) {
                Badge()
            }
            """#
    )

    var body: some View {
        VStack(alignment: trailing ? .trailing : .leading, spacing: 8) {
            Text("Title").font(.headline)
            Text("Subtitle").font(.subheadline).foregroundStyle(.secondary)
            HStack {
                Text("Left")
                Spacer()
                Text("Right")
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(.quaternary, in: RoundedRectangle(cornerRadius: 12))
        .overlay(alignment: .topTrailing) {
            Image(systemName: "star.fill")
                .foregroundStyle(.yellow)
                .padding(8)
        }
        .onChange(of: play) { _, _ in
            withAnimation(.snappy) { trailing.toggle() }
        }
    }
}
