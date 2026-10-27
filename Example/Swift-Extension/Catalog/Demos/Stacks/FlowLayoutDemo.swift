//  FlowLayoutDemo.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI

struct FlowLayoutDemo: View {
    let play: Int
    @State private var tags = ["SwiftUI", "Layout", "Grid", "Animation", "Text", "Scroll", "Keyboard", "Array"]

    static let info = ExampleInfo(
        category: .stacks,
        title: "Custom flow layout",
        summary: "A custom Layout (iOS 16) that wraps chips onto new rows. Shows sizeThatFits and placeSubviews.",
        code: #"""
        struct FlowLayout: Layout {
            var spacing: CGFloat = 8

            func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
                // measure each row, sum heights, return the widest row
            }

            func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
                // walk subviews, start a new row when the width runs out
            }
        }

        FlowLayout(spacing: 8) {
            ForEach(tags, id: \.self) { tag in
                Text(tag).padding(8).background(.tint.opacity(0.15), in: Capsule())
            }
        }
        """#
    )

    var body: some View {
        FlowLayout(spacing: 8) {
            ForEach(tags, id: \.self) { tag in
                Text(tag)
                    .font(.callout)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(.tint.opacity(0.15), in: Capsule())
            }
        }
        .frame(maxWidth: .infinity)
        .onChange(of: play) { _, _ in
            withAnimation(.smooth) { tags.shuffle() }
        }
    }
}
