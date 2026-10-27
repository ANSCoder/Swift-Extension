//  LoadingOverlayDemo.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI
import SwiftExtension

struct LoadingOverlayDemo: View {
    let play: Int
    @State private var loading = false

    static let info = ExampleInfo(
        category: .modifiers,
        title: "Loading overlay",
        summary: "loadingOverlay(_:) dims content, shows a spinner and blocks taps while work runs.",
        code: #"""
        @State private var loading = false

        VStack {
            Text("Content underneath")
        }
        .loadingOverlay(loading)

        Button("Load") {
            loading = true
            Task {
                try? await Task.sleep(for: .seconds(2))
                loading = false
            }
        }
        """#
    )

    var body: some View {
        VStack(spacing: 16) {
            Text("Content underneath")
                .font(.headline)
            Button("Load for 2 s") { Task { await load() } }
                .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .loadingOverlay(loading)
        .task(id: play) {
            guard play > 0 else { return }
            await load()
        }
    }

    private func load() async {
        loading = true
        defer { loading = false }
        try? await Task.sleep(for: .seconds(2))
    }
}
