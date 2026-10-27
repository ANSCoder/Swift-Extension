//  ScrollDismissesDemo.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI
import SwiftExtension

struct ScrollDismissesDemo: View {
    let play: Int
    @State private var reply = ""
    @FocusState private var focused: Bool

    static let info = ExampleInfo(
        category: .keyboard,
        title: "Scroll dismisses keyboard",
        summary: "scrollDismissesKeyboard(.interactively) follows the finger down, like Messages.",
        code: #"""
            @State private var reply = ""

            ScrollView {
                VStack(spacing: 12) {
                    ForEach(0..<15, id: \.self) { index in
                        Text("Message \(index)")
                    }
                    TextField("Reply", text: $reply)
                        .textFieldStyle(.roundedBorder)
                }
            }
            .scrollDismissesKeyboard(.interactively)
            """#
    )

    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                ForEach(0..<12, id: \.self) { index in
                    Text("Message \(index)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(8)
                        .background(.quaternary, in: RoundedRectangle(cornerRadius: 8))
                }
                TextField("Reply", text: $reply)
                    .textFieldStyle(.roundedBorder)
                    .focused($focused)
            }
        }
        .scrollDismissesKeyboard(.interactively)
        .onChange(of: play) { _, _ in focused = true }
    }
}
