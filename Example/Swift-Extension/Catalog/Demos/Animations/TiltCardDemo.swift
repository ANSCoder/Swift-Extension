//  TiltCardDemo.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI
import SwiftExtension

struct TiltCardDemo: View {
    let play: Int
    @State private var tilt = CGSize.zero

    static let info = ExampleInfo(
        category: .animations,
        title: "3D tilt card",
        summary: "rotation3DEffect follows the finger, a glare gradient and shadow shift with it, and release springs back.",
        code: #"""
            @State private var tilt = CGSize.zero

            card
                .rotation3DEffect(.degrees(Double(tilt.width) / 6), axis: (x: 0, y: 1, z: 0), perspective: 0.6)
                .rotation3DEffect(.degrees(Double(-tilt.height) / 6), axis: (x: 1, y: 0, z: 0), perspective: 0.6)
                .shadow(color: .indigo.opacity(0.4), radius: 20, x: -tilt.width / 10, y: 12 + tilt.height / 10)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            tilt = CGSize(
                                width: value.translation.width.clamped(to: -120...120),
                                height: value.translation.height.clamped(to: -120...120)
                            )
                        }
                        .onEnded { _ in
                            withAnimation(.spring(response: 0.5, dampingFraction: 0.55)) { tilt = .zero }
                        }
                )
            """#
    )

    var body: some View {
        RoundedRectangle(cornerRadius: 24, style: .continuous)
            .fill(Palette.brandGradient)
            .frame(width: 250, height: 160)
            .overlay(alignment: .topLeading) {
                VStack(alignment: .leading, spacing: 6) {
                    Image(systemName: "curlybraces")
                        .font(.title2.weight(.bold))
                    Spacer()
                    Text("Swift Extension")
                        .font(.headline)
                    Text("Live examples")
                        .font(.caption)
                        .opacity(0.85)
                }
                .foregroundStyle(.white)
                .padding(18)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
            .overlay {
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: [.white.opacity(0.35), .clear],
                            startPoint: UnitPoint(x: 0.2 + tilt.width / 300, y: 0),
                            endPoint: UnitPoint(x: 0.8 + tilt.width / 300, y: 1)
                        )
                    )
                    .allowsHitTesting(false)
            }
            .rotation3DEffect(.degrees(Double(tilt.width) / 6), axis: (x: 0, y: 1, z: 0), perspective: 0.6)
            .rotation3DEffect(.degrees(Double(-tilt.height) / 6), axis: (x: 1, y: 0, z: 0), perspective: 0.6)
            .shadow(color: Palette.accent.opacity(0.4), radius: 20, x: -tilt.width / 10, y: 12 + tilt.height / 10)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        tilt = CGSize(
                            width: value.translation.width.clamped(to: -120...120),
                            height: value.translation.height.clamped(to: -120...120)
                        )
                    }
                    .onEnded { _ in
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.55)) { tilt = .zero }
                    }
            )
            .accessibilityLabel("Swift Extension card")
            .task(id: play) {
                guard play > 0 else { return }
                withAnimation(.easeInOut(duration: 0.6)) { tilt = CGSize(width: 90, height: -50) }
                try? await Task.sleep(for: .milliseconds(650))
                guard !Task.isCancelled else { return }
                withAnimation(.easeInOut(duration: 0.8)) { tilt = CGSize(width: -90, height: 50) }
                try? await Task.sleep(for: .milliseconds(850))
                guard !Task.isCancelled else { return }
                withAnimation(.spring(response: 0.5, dampingFraction: 0.55)) { tilt = .zero }
            }
    }
}
