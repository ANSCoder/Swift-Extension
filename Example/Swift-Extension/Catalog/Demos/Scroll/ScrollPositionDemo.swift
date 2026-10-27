//  ScrollPositionDemo.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI

struct ScrollPositionDemo: View {
    let play: Int
    @State private var rowID: Int?

    static let info = ExampleInfo(
        category: .scroll,
        title: "Read & set scroll position",
        summary: "scrollPosition(id:) reads the visible row and drives it from state (iOS 17). No proxy needed.",
        code: #"""
        @State private var rowID: Int?

        ScrollView {
            LazyVStack {
                ForEach(0..<40, id: \.self) { row in
                    Text("Row \(row)").id(row)
                }
            }
            .scrollTargetLayout()
        }
        .scrollPosition(id: $rowID)

        Button("Row 20") { rowID = 20 }
        """#
    )

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Text("Visible row: \(rowID ?? 0)")
                    .font(.footnote.monospacedDigit())
                Spacer()
                Button("Go to 20") { rowID = 20 }
                    .buttonStyle(.bordered)
            }

            ScrollView {
                LazyVStack(spacing: 8) {
                    ForEach(0..<40, id: \.self) { row in
                        Text("Row \(row)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(10)
                            .background(.quaternary, in: RoundedRectangle(cornerRadius: 8))
                            .id(row)
                    }
                }
                .scrollTargetLayout()
            }
            .scrollPosition(id: $rowID)
        }
        .onChange(of: play) { _, _ in
            withAnimation { rowID = 20 }
        }
    }
}
