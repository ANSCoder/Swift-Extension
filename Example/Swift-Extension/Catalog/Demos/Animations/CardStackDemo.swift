//  CardStackDemo.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI
import SwiftExtension

struct CardStackDemo: View {
    let play: Int
    @State private var cards = Array(0..<5)
    @State private var drag = CGSize.zero
    private let colors = ["4F46E5", "0D9488", "D97706", "DB2777", "2563EB"]
    private let symbols = ["bolt.fill", "leaf.fill", "flame.fill", "heart.fill", "star.fill"]

    static let info = ExampleInfo(
        category: .animations,
        title: "Swipeable card stack",
        summary: "DragGesture on the top card, depth-based scale and offset for the rest. Fly off past a threshold, spring back otherwise.",
        code: #"""
        @State private var cards = Array(0..<5)
        @State private var drag = CGSize.zero

        ZStack {
            ForEach(Array(cards.enumerated().reversed()), id: \.element) { depth, card in
                CardView(card)
                    .scaleEffect(1 - CGFloat(depth) * 0.06)
                    .offset(x: depth == 0 ? drag.width : 0, y: CGFloat(depth) * 14)
                    .rotationEffect(.degrees(depth == 0 ? Double(drag.width / 18) : 0))
                    .allowsHitTesting(depth == 0)
                    .gesture(
                        DragGesture()
                            .onChanged { drag = $0.translation }
                            .onEnded { value in
                                if abs(value.translation.width) > 110 {
                                    // fly off, then remove the top card
                                } else {
                                    withAnimation(.spring) { drag = .zero }
                                }
                            }
                    )
            }
        }
        """#
    )

    var body: some View {
        ZStack {
            if cards.isEmpty {
                Label("All caught up", systemImage: "checkmark.circle")
                    .font(.headline)
                    .foregroundStyle(Palette.secondaryText)
            }
            ForEach(Array(cards.enumerated().reversed()), id: \.element) { depth, card in
                cardView(card, depth: depth)
            }
        }
        .onChange(of: play) { _, _ in
            withAnimation(.spring) {
                cards = Array(0..<5)
                drag = .zero
            }
        }
    }

    private func cardView(_ card: Int, depth: Int) -> some View {
        let isTop = depth == 0
        let color = Color(hex: colors[card % colors.count])
        return RoundedRectangle(cornerRadius: 22, style: .continuous)
            .fill(LinearGradient(colors: [color, color.opacity(0.75)], startPoint: .topLeading, endPoint: .bottomTrailing))
            .frame(width: 240, height: 180)
            .overlay {
                VStack(spacing: 8) {
                    Image(systemName: symbols[card % symbols.count]).font(.largeTitle)
                    Text("Card \(card + 1)").font(.headline)
                }
                .foregroundStyle(.white)
            }
            .shadow(color: .black.opacity(0.15), radius: 10, y: 6)
            .scaleEffect(1 - CGFloat(depth) * 0.06)
            .offset(x: isTop ? drag.width : 0, y: CGFloat(depth) * 14 + (isTop ? drag.height / 6 : 0))
            .rotationEffect(.degrees(isTop ? Double(drag.width / 18) : 0))
            .animation(.spring(response: 0.4, dampingFraction: 0.75), value: depth)
            .allowsHitTesting(isTop)
            .gesture(swipe)
            .accessibilityLabel("Card \(card + 1)")
    }

    private var swipe: some Gesture {
        DragGesture()
            .onChanged { drag = $0.translation }
            .onEnded { value in
                if abs(value.translation.width) > 110 {
                    let direction: CGFloat = value.translation.width > 0 ? 1 : -1
                    withAnimation(.easeIn(duration: 0.22)) {
                        drag = CGSize(width: direction * 500, height: value.translation.height)
                    } completion: {
                        if !cards.isEmpty { cards.removeFirst() }
                        drag = .zero
                    }
                } else {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) { drag = .zero }
                }
            }
    }
}
