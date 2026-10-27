//  ScaledMetricDemo.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI

struct ScaledMetricDemo: View {
    let play: Int
    @State private var accessibilitySize = false
    @ScaledMetric(relativeTo: .title) private var iconSize: CGFloat = 40

    static let info = ExampleInfo(
        category: .text,
        title: "Dynamic Type scaling",
        summary: "@ScaledMetric scales plain numbers with the user's text size. Toggle to see accessibility sizes.",
        code: #"""
        @ScaledMetric(relativeTo: .title) private var iconSize: CGFloat = 40

        Image(systemName: "star.fill")
            .font(.system(size: iconSize))
            .dynamicTypeSize(accessibilitySize ? .accessibility3 : .medium)
        """#
    )

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "star.fill")
                .font(.system(size: iconSize))
                .foregroundStyle(.yellow)
            Text("Scales with Dynamic Type")
                .font(.headline)
            Toggle("Accessibility size", isOn: $accessibilitySize)
                .font(.footnote)
        }
        .dynamicTypeSize(accessibilitySize ? .accessibility3 : .medium)
        .onChange(of: play) { _, _ in
            withAnimation { accessibilitySize.toggle() }
        }
    }
}
