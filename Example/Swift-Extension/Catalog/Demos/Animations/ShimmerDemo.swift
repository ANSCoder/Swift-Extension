//  ShimmerDemo.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI
import SwiftExtension

struct ShimmerDemo: View {
    let play: Int
    @State private var loading = false
    private let names = ["Anand Nimje", "Priya Shah", "Liam Chen"]
    private let roles = ["iOS engineer", "Product designer", "Data scientist"]

    static let info = ExampleInfo(
        category: .animations,
        title: "Skeleton shimmer",
        summary: "redactedShimmer(_:) turns real content into a placeholder with a moving highlight while data loads.",
        code: #"""
        @State private var loading = true

        VStack {
            ForEach(users) { user in
                HStack {
                    Circle().fill(loading ? .gray.opacity(0.3) : .indigo)
                        .frame(width: 46, height: 46)
                    VStack(alignment: .leading) {
                        Text(user.name).font(.headline)
                        Text(user.role).font(.subheadline)
                    }
                }
            }
        }
        .redactedShimmer(loading)   // library extension
        """#
    )

    var body: some View {
        VStack(spacing: 20) {
            ForEach(names.indices, id: \.self) { index in
                HStack(spacing: 12) {
                    Circle()
                        .fill(loading ? Color.gray.opacity(0.3) : Palette.series[index])
                        .frame(width: 46, height: 46)
                    VStack(alignment: .leading, spacing: 4) {
                        Text(names[index]).font(.headline)
                        Text(roles[index]).font(.subheadline)
                    }
                    Spacer()
                }
            }
        }
        .padding(.horizontal, 8)
        .redactedShimmer(loading)
        .task(id: play) {
            guard play > 0 else { return }
            loading = true
            try? await Task.sleep(for: .seconds(2))
            guard !Task.isCancelled else { return }
            withAnimation(.smooth) { loading = false }
        }
    }
}
