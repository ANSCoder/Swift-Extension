//  ExampleDetailView.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI

/// One example: category badges, summary, live stage, how-to-play hint, Play button and code.
struct ExampleDetailView: View {
    let example: Example
    @State private var playCount = 0

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                HStack(spacing: 8) {
                    InfoPill(text: example.info.category.title, systemImage: example.info.category.symbol, tint: example.info.category.tint)
                    InfoPill(text: "iOS 17+", systemImage: "iphone", tint: Palette.secondaryText)
                }

                Text(example.info.summary)
                    .font(.body)
                    .foregroundStyle(Palette.secondaryText)

                example.demo(play: playCount)
                    .frame(maxWidth: .infinity)
                    .frame(height: 320)
                    .padding(16)
                    .background { StageBackground(tint: example.info.category.tint) }
                    .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                    .overlay {
                        RoundedRectangle(cornerRadius: 24, style: .continuous)
                            .strokeBorder(Palette.stroke)
                    }

                HintCalloutView(text: example.playHint)

                Button {
                    playCount += 1
                } label: {
                    Label("Play", systemImage: "play.fill")
                }
                .buttonStyle(PlayButtonStyle())

                CodeBlockView(code: example.info.code)
            }
            .padding(20)
        }
        .background(Palette.background)
        .navigationTitle(example.info.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        ExampleDetailView(example: .confetti)
    }
}
