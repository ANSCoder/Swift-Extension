//  HintCalloutView.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI

/// "How to play" note shown under the demo stage.
struct HintCalloutView: View {
    let text: String

    var body: some View {
        Label(text, systemImage: "hand.tap.fill")
            .font(.subheadline)
            .foregroundStyle(Palette.secondaryText)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(14)
            .background(Palette.surface, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .strokeBorder(Palette.stroke)
            }
    }
}
