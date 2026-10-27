//  CategoryFilterBar.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI

/// Horizontal chips that filter the catalog by category. `nil` means all.
struct CategoryFilterBar: View {
    @Binding var selection: ExampleCategory?

    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 8) {
                chip(title: "All", symbol: "square.grid.2x2", tint: Palette.accent, category: nil)
                ForEach(ExampleCategory.allCases) { category in
                    chip(title: category.title, symbol: category.symbol, tint: category.tint, category: category)
                }
            }
            .padding(.horizontal, 20)
        }
        .scrollIndicators(.hidden)
    }

    private func chip(title: String, symbol: String, tint: Color, category: ExampleCategory?) -> some View {
        let isSelected = selection == category
        return Button {
            withAnimation(.snappy) { selection = category }
        } label: {
            Label(title, systemImage: symbol)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(isSelected ? Color.white : Color.primary)
                .padding(.horizontal, 14)
                .padding(.vertical, 9)
                .background(isSelected ? AnyShapeStyle(tint) : AnyShapeStyle(Palette.surface), in: Capsule())
                .overlay { Capsule().strokeBorder(isSelected ? Color.clear : Palette.stroke) }
        }
        .buttonStyle(.plain)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}
