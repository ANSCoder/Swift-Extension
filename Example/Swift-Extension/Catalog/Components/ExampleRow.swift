//  ExampleRow.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI

/// One tappable example in a category card.
struct ExampleRow: View {
    let example: Example

    var body: some View {
        NavigationLink(value: example) {
            HStack(spacing: 14) {
                CategoryIconTile(symbol: example.info.category.symbol, tint: example.info.category.tint, size: 38)
                VStack(alignment: .leading, spacing: 2) {
                    Text(example.info.title)
                        .font(.body.weight(.semibold))
                        .foregroundStyle(.primary)
                    Text(example.info.summary)
                        .font(.footnote)
                        .foregroundStyle(Palette.secondaryText)
                        .lineLimit(2)
                }
                Spacer(minLength: 8)
                Image(systemName: "chevron.right")
                    .font(.footnote.weight(.semibold))
                    .foregroundStyle(Palette.secondaryText)
                    .accessibilityHidden(true)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}
