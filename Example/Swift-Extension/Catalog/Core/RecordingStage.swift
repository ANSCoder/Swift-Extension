//  RecordingStage.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI

/// Bare, auto-playing stage used to record the README GIFs.
/// Launch with `-example <caseName>` (e.g. `-example confetti`) to show it.
struct RecordingStage: View {
    let example: Example
    @State private var play = 0

    var body: some View {
        example.demo(play: play)
            .frame(width: 350, height: 300)
            .padding(8)
            .background { StageBackground(tint: example.info.category.tint) }
            .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Palette.background)
            .ignoresSafeArea()
            .task {
                try? await Task.sleep(for: .seconds(1))
                while !Task.isCancelled {
                    play += 1
                    try? await Task.sleep(for: .seconds(2.5))
                }
            }
    }
}
