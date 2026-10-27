//  ViewThatFitsDemo.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI

struct ViewThatFitsDemo: View {
    let play: Int
    @State private var width: CGFloat = 300

    static let info = ExampleInfo(
        category: .stacks,
        title: "View that fits",
        summary: "ViewThatFits picks the first child that fits the offered space. Responsive layout with no GeometryReader.",
        code: #"""
        ViewThatFits(in: .horizontal) {
            HStack {
                Image(systemName: "bolt.fill")
                Text("Plenty of room for one line")
            }
            VStack(alignment: .leading) {
                Image(systemName: "bolt.fill")
                Text("Stacked when tight")
            }
        }
        """#
    )

    var body: some View {
        VStack(spacing: 16) {
            ViewThatFits(in: .horizontal) {
                HStack {
                    Image(systemName: "bolt.fill")
                    Text("Plenty of room for one line")
                }
                VStack(alignment: .leading) {
                    Image(systemName: "bolt.fill")
                    Text("Stacked when tight")
                }
            }
            .padding()
            .frame(width: width)
            .background(.tint.opacity(0.15), in: RoundedRectangle(cornerRadius: 12))

            Slider(value: $width, in: 120...320)
        }
        .onChange(of: play) { _, _ in
            withAnimation(.smooth) { width = width > 200 ? 120 : 320 }
        }
    }
}
