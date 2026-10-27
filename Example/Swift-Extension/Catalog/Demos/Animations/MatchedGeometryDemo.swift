//  MatchedGeometryDemo.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI

struct MatchedGeometryDemo: View {
    let play: Int
    @State private var expanded = false
    @Namespace private var namespace

    static let info = ExampleInfo(
        category: .animations,
        title: "Matched geometry (hero)",
        summary: "matchedGeometryEffect morphs one view into another across layouts. Shared id + namespace.",
        code: #"""
        @Namespace private var namespace
        @State private var expanded = false

        VStack {
            if expanded {
                tile(size: 160)
            } else {
                HStack { tile(size: 56); Spacer() }
            }
        }
        .onTapGesture {
            withAnimation(.spring) { expanded.toggle() }
        }

        func tile(size: CGFloat) -> some View {
            Circle()
                .frame(width: size, height: size)
                .matchedGeometryEffect(id: "tile", in: namespace)
        }
        """#
    )

    var body: some View {
        VStack {
            if expanded {
                Spacer()
                tile(size: 160)
                Spacer()
            } else {
                HStack {
                    tile(size: 56)
                    Spacer()
                }
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .contentShape(Rectangle())
        .onTapGesture { toggle() }
        .onChange(of: play) { _, _ in toggle() }
    }

    private func tile(size: CGFloat) -> some View {
        Circle()
            .fill(.pink.gradient)
            .frame(width: size, height: size)
            .matchedGeometryEffect(id: "tile", in: namespace)
    }

    private func toggle() {
        withAnimation(.spring(response: 0.5, dampingFraction: 0.75)) { expanded.toggle() }
    }
}
