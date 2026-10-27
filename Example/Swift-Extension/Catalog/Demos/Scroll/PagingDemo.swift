//  PagingDemo.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI

struct PagingDemo: View {
    let play: Int
    @State private var page: Int?
    private let colors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple]

    static let info = ExampleInfo(
        category: .scroll,
        title: "Paging scroll",
        summary: "Snap-to-page horizontal scroll with containerRelativeFrame (iOS 17).",
        code: #"""
        @State private var page: Int?

        ScrollView(.horizontal) {
            LazyHStack(spacing: 0) {
                ForEach(0..<6, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 16)
                        .containerRelativeFrame(.horizontal) { width, _ in width - 32 }
                        .id(index)
                }
            }
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.paging)
        .scrollPosition(id: $page)
        """#
    )

    var body: some View {
        VStack(spacing: 12) {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 0) {
                    ForEach(0..<colors.count, id: \.self) { index in
                        RoundedRectangle(cornerRadius: 16)
                            .fill(colors[index].gradient)
                            .containerRelativeFrame(.horizontal) { width, _ in width - 32 }
                            .overlay { Text("Page \(index + 1)").font(.title2.bold()).foregroundStyle(.white) }
                            .id(index)
                    }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.paging)
            .scrollPosition(id: $page)
            .frame(height: 160)

            Text("Page \((page ?? 0) + 1) of \(colors.count)")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
        .onChange(of: play) { _, _ in
            withAnimation { page = ((page ?? 0) + 1) % colors.count }
        }
    }
}
