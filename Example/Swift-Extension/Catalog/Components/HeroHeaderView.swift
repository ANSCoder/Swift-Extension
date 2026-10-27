//  HeroHeaderView.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI

/// Gradient banner at the top of the catalog.
struct HeroHeaderView: View {
    let exampleCount: Int
    let categoryCount: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Image(systemName: "curlybraces")
                .font(.system(size: 22, weight: .bold))
                .frame(width: 48, height: 48)
                .background(.white.opacity(0.2), in: RoundedRectangle(cornerRadius: 14, style: .continuous))
                .accessibilityHidden(true)

            VStack(alignment: .leading, spacing: 4) {
                Text("Swift Extension")
                    .font(.largeTitle.bold())
                Text("Live, copy-ready SwiftUI and UIKit extensions.")
                    .font(.subheadline)
                    .opacity(0.9)
            }

            HStack(spacing: 8) {
                stat("\(exampleCount) examples")
                stat("\(categoryCount) categories")
                stat("iOS 17+")
            }
        }
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .background {
            ZStack(alignment: .topTrailing) {
                Palette.brandGradient
                Circle()
                    .fill(.white.opacity(0.12))
                    .frame(width: 180, height: 180)
                    .offset(x: 50, y: -60)
            }
            .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
        }
    }

    private func stat(_ text: String) -> some View {
        Text(text)
            .font(.caption.weight(.semibold))
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(.white.opacity(0.2), in: Capsule())
    }
}
