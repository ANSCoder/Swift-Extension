//  MarkdownTextDemo.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI

struct MarkdownTextDemo: View {
    let play: Int
    @State private var highlighted = false

    static let info = ExampleInfo(
        category: .text,
        title: "Markdown & AttributedString",
        summary: "Text(markdown) for inline styling; AttributedString for per-run colors and fonts (iOS 15+).",
        code: #"""
        Text("**Bold**, *italic*, `code` and [a link](https://swift.org)")

        var styled = AttributedString("Styled ")
        styled.foregroundColor = .blue
        var emphasis = AttributedString("markdown")
        emphasis.font = .title3.bold()
        Text(styled + emphasis)
        """#
    )

    private var styled: AttributedString {
        var base = AttributedString("Styled ")
        base.foregroundColor = highlighted ? .orange : .blue
        var emphasis = AttributedString("markdown")
        emphasis.font = .title3.bold()
        return base + emphasis
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("**Bold**, *italic*, `code` and [a link](https://swift.org)")
            Text(styled)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .onChange(of: play) { _, _ in
            withAnimation { highlighted.toggle() }
        }
    }
}
