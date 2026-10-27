//  DragSpringDemo.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI

struct DragSpringDemo: View {
    let play: Int
    @State private var offset = CGSize.zero

    static let info = ExampleInfo(
        category: .animations,
        title: "Drag with spring release",
        summary: "DragGesture updates state live; onEnded springs back. Interactive, physics-like motion.",
        code: #"""
        @State private var offset = CGSize.zero

        Circle()
            .offset(offset)
            .gesture(
                DragGesture()
                    .onChanged { offset = $0.translation }
                    .onEnded { _ in
                        withAnimation(.bouncy) { offset = .zero }
                    }
            )
        """#
    )

    var body: some View {
        Circle()
            .fill(.indigo.gradient)
            .frame(width: 90, height: 90)
            .offset(offset)
            .gesture(
                DragGesture()
                    .onChanged { offset = $0.translation }
                    .onEnded { _ in
                        withAnimation(.bouncy) { offset = .zero }
                    }
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onChange(of: play) { _, _ in
                withAnimation(.bouncy) {
                    offset = CGSize(width: CGFloat.random(in: -90...90), height: CGFloat.random(in: -110...60))
                }
            }
    }
}
