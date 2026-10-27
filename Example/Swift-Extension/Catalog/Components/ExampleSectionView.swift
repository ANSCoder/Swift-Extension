//  ExampleSectionView.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI

/// A category title plus a card listing its examples.
struct ExampleSectionView: View {
    let category: ExampleCategory
    let examples: [Example]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 8) {
                Text(category.title)
                    .font(.title3.bold())
                Text("\(examples.count)")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(category.tint)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 2)
                    .background(category.tint.opacity(0.14), in: Capsule())
                    .accessibilityLabel("\(examples.count) examples")
            }
            .accessibilityAddTraits(.isHeader)
            .padding(.horizontal, 4)

            VStack(spacing: 0) {
                ForEach(Array(examples.enumerated()), id: \.element) { index, example in
                    ExampleRow(example: example)
                    if index < examples.count - 1 {
                        Divider().padding(.leading, 68)
                    }
                }
            }
            .background(Palette.surface, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .strokeBorder(Palette.stroke)
            }
        }
    }
}
