//  SnapshotViewDemo.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI
import SwiftExtension

struct SnapshotViewDemo: View {
    let play: Int
    @State private var captured: UIImage?
    @State private var stamp = Date.now

    static let info = ExampleInfo(
        category: .modifiers,
        title: "View to image",
        summary: "snapshot(scale:) renders any SwiftUI view into a UIImage with ImageRenderer. Share it, save it, or print it.",
        code: #"""
        @State private var image: UIImage?

        let badge = VStack {
            Image(systemName: "seal.fill")
            Text("Snapshot")
        }

        Button("Capture") {
            image = badge.snapshot(scale: 3)   // library extension
        }
        """#
    )

    private var badge: some View {
        VStack(spacing: 6) {
            Image(systemName: "seal.fill")
                .font(.largeTitle)
                .foregroundStyle(Palette.brandGradient)
            Text("Snapshot").font(.headline)
            Text(stamp.toTimeString()).font(.caption.monospacedDigit()).foregroundStyle(.secondary)
        }
        .padding(20)
        .frame(width: 130)
        .background(Palette.surface, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
    }

    var body: some View {
        HStack(spacing: 20) {
            VStack(spacing: 12) {
                badge
                Button("Capture") { capture() }
                    .buttonStyle(.borderedProminent)
            }
            VStack(spacing: 6) {
                if let captured {
                    Image(uiImage: captured)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 110)
                        .overlay { Rectangle().strokeBorder(Palette.accent, style: StrokeStyle(lineWidth: 1, dash: [4])) }
                        .accessibilityLabel("Captured image")
                    Text("UIImage \(Int(captured.size.width))×\(Int(captured.size.height))")
                        .font(.caption2.monospacedDigit())
                        .foregroundStyle(Palette.secondaryText)
                } else {
                    Text("No capture yet")
                        .font(.footnote)
                        .foregroundStyle(Palette.secondaryText)
                }
            }
            .frame(width: 120)
        }
        .onChange(of: play) { _, _ in capture() }
    }

    private func capture() {
        stamp = .now
        captured = badge.snapshot(scale: 3)
    }
}
