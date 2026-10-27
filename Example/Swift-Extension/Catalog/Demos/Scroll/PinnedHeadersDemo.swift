//  PinnedHeadersDemo.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI

struct PinnedHeadersDemo: View {
    let play: Int

    static let info = ExampleInfo(
        category: .scroll,
        title: "Pinned section headers",
        summary: "LazyVStack(pinnedViews:) keeps each section header on screen while its rows scroll.",
        code: #"""
            ScrollView {
                LazyVStack(pinnedViews: [.sectionHeaders]) {
                    ForEach(0..<3, id: \.self) { section in
                        Section {
                            ForEach(0..<6, id: \.self) { item in
                                Text("Item \(section).\(item)")
                            }
                        } header: {
                            Text("Section \(section)")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(8)
                                .background(.thinMaterial)
                        }
                    }
                }
            }
            """#
    )

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 6, pinnedViews: [.sectionHeaders]) {
                    ForEach(0..<4, id: \.self) { section in
                        Section {
                            ForEach(0..<6, id: \.self) { item in
                                Text("Item \(section).\(item)")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.horizontal)
                                    .id(section * 10 + item)
                            }
                        } header: {
                            Text("Section \(section)")
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(8)
                                .background(.thinMaterial)
                        }
                    }
                }
            }
            .onChange(of: play) { _, _ in
                withAnimation { proxy.scrollTo(20, anchor: .top) }
            }
        }
    }
}
