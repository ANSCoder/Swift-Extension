//  ScrollTransitionDemo.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI

struct ScrollTransitionDemo: View {
    let play: Int

    static let info = ExampleInfo(
        category: .scroll,
        title: "Scroll transition",
        summary: "scrollTransition ties effects to each row's position in the viewport (iOS 17). Cheap parallax-style polish.",
        code: #"""
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(0..<30, id: \.self) { row in
                    RoundedRectangle(cornerRadius: 16)
                        .frame(height: 80)
                        .scrollTransition(axis: .vertical) { content, phase in
                            content
                                .opacity(phase.isIdentity ? 1 : 0.2)
                                .scaleEffect(phase.isIdentity ? 1 : 0.8)
                        }
                }
            }
        }
        """#
    )

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(0..<30, id: \.self) { row in
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.teal.gradient)
                            .frame(height: 70)
                            .overlay { Text("Card \(row)").font(.headline).foregroundStyle(.white) }
                            .scrollTransition(axis: .vertical) { content, phase in
                                content
                                    .opacity(phase.isIdentity ? 1 : 0.2)
                                    .scaleEffect(phase.isIdentity ? 1 : 0.8)
                            }
                            .id(row)
                    }
                }
                .padding(.horizontal)
            }
            .onChange(of: play) { _, _ in
                withAnimation { proxy.scrollTo(15, anchor: .center) }
            }
        }
    }
}
