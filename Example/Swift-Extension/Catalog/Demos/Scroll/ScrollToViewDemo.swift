//  ScrollToViewDemo.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI

struct ScrollToViewDemo: View {
    let play: Int

    static let info = ExampleInfo(
        category: .scroll,
        title: "Scroll to view",
        summary: "Jump so a target row sits at the top. Mirrors UIScrollView scrollToView(view:animated:).",
        code: #"""
            ScrollViewReader { proxy in
                Button("Jump to row 20") {
                    withAnimation { proxy.scrollTo(20, anchor: .top) }
                }
                ScrollView {
                    LazyVStack {
                        ForEach(0..<40, id: \.self) { row in
                            Text("Row \(row)").id(row)
                        }
                    }
                }
            }
            """#
    )

    var body: some View {
        ScrollViewReader { proxy in
            VStack {
                Button("Jump to row 20") { jump(proxy) }
                    .buttonStyle(.bordered)

                ScrollView {
                    LazyVStack(spacing: 8) {
                        ForEach(0..<40, id: \.self) { row in
                            Text("Row \(row)")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(10)
                                .background(.quaternary, in: RoundedRectangle(cornerRadius: 8))
                                .id(row)
                        }
                    }
                }
                .onChange(of: play) { _, _ in jump(proxy) }
            }
        }
    }

    private func jump(_ proxy: ScrollViewProxy) {
        withAnimation { proxy.scrollTo(20, anchor: .top) }
    }
}
