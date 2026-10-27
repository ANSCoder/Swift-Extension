//  CategoryIconTile.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI

/// Rounded gradient tile with an SF Symbol. Decorative, hidden from VoiceOver.
struct CategoryIconTile: View {
    let symbol: String
    let tint: Color
    var size: CGFloat = 40

    var body: some View {
        Image(systemName: symbol)
            .font(.system(size: size * 0.45, weight: .semibold))
            .foregroundStyle(.white)
            .frame(width: size, height: size)
            .background(
                LinearGradient(colors: [tint, tint.opacity(0.7)], startPoint: .topLeading, endPoint: .bottomTrailing),
                in: RoundedRectangle(cornerRadius: size * 0.28, style: .continuous)
            )
            .accessibilityHidden(true)
    }
}
