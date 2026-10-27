//  SlidingSegmentsDemo.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI

struct SlidingSegmentsDemo: View {
    let play: Int
    @State private var selection = 0
    @Namespace private var namespace
    private let items = ["Day", "Week", "Month", "Year"]
    private let visits = [128, 904, 3_870, 46_210]

    static let info = ExampleInfo(
        category: .animations,
        title: "Sliding segmented control",
        summary: "One highlight shared across segments with matchedGeometryEffect, plus a numeric transition for the value.",
        code: #"""
            @State private var selection = 0
            @Namespace private var namespace

            HStack(spacing: 0) {
                ForEach(items.indices, id: \.self) { index in
                    Button { withAnimation(.snappy) { selection = index } } label: {
                        Text(items[index])
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                            .background {
                                if selection == index {
                                    Capsule().fill(.indigo)
                                        .matchedGeometryEffect(id: "pill", in: namespace)
                                }
                            }
                    }
                    .accessibilityAddTraits(selection == index ? .isSelected : [])
                }
            }
            """#
    )

    var body: some View {
        VStack(spacing: 28) {
            HStack(spacing: 0) {
                ForEach(items.indices, id: \.self) { index in
                    Button {
                        select(index)
                    } label: {
                        Text(items[index])
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(selection == index ? Color.white : Color.primary)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                            .background {
                                if selection == index {
                                    Capsule()
                                        .fill(Palette.brandGradient)
                                        .matchedGeometryEffect(id: "pill", in: namespace)
                                }
                            }
                    }
                    .buttonStyle(.plain)
                    .accessibilityAddTraits(selection == index ? .isSelected : [])
                }
            }
            .padding(4)
            .background(Palette.surface, in: Capsule())
            .overlay { Capsule().strokeBorder(Palette.stroke) }

            VStack(spacing: 4) {
                Text(visits[selection], format: .number)
                    .font(.system(size: 48, weight: .bold, design: .rounded).monospacedDigit())
                    .contentTransition(.numericText(value: Double(visits[selection])))
                Text("visits this \(items[selection].lowercased())")
                    .font(.subheadline)
                    .foregroundStyle(Palette.secondaryText)
            }
        }
        .onChange(of: play) { _, _ in select((selection + 1) % items.count) }
    }

    private func select(_ index: Int) {
        withAnimation(.snappy(duration: 0.4)) { selection = index }
    }
}
