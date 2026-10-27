//  ScrollToTopDemo.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI

struct ScrollToTopDemo: View {
    let play: Int

    static let info = ExampleInfo(
        category: .scroll,
        title: "Scroll to top & bottom",
        summary: "ScrollViewReader jumps to a row by id. Same idea as UIScrollView scrollToTop / scrollToBottom.",
        code: #"""
        ScrollViewReader { proxy in
            VStack {
                HStack {
                    Button("Top") { withAnimation { proxy.scrollTo(0, anchor: .top) } }
                    Button("Bottom") { withAnimation { proxy.scrollTo(49, anchor: .bottom) } }
                }
                ScrollView {
                    LazyVStack {
                        ForEach(0..<50, id: \.self) { row in
                            Text("Row \(row)").id(row)
                        }
                    }
                }
            }
        }
        """#
    )

    var body: some View {
        ScrollViewReader { proxy in
            VStack {
                HStack {
                    Button("Top") { withAnimation { proxy.scrollTo(0, anchor: .top) } }
                    Button("Bottom") { withAnimation { proxy.scrollTo(49, anchor: .bottom) } }
                }
                .buttonStyle(.bordered)

                ScrollView {
                    LazyVStack(spacing: 8) {
                        ForEach(0..<50, id: \.self) { row in
                            Text("Row \(row)")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(10)
                                .background(.quaternary, in: RoundedRectangle(cornerRadius: 8))
                                .id(row)
                        }
                    }
                }
                .onChange(of: play) { _, _ in
                    withAnimation { proxy.scrollTo(49, anchor: .bottom) }
                }
            }
        }
    }
}
