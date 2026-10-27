//  DismissOnTapDemo.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI
import SwiftExtension

struct DismissOnTapDemo: View {
    let play: Int
    @State private var text = ""
    @FocusState private var focused: Bool

    static let info = ExampleInfo(
        category: .keyboard,
        title: "Dismiss keyboard on tap",
        summary: "dismissKeyboardOnTap() resigns the first responder when empty space is tapped (library helper).",
        code: #"""
        @State private var text = ""

        VStack {
            TextField("Type here", text: $text)
                .textFieldStyle(.roundedBorder)
            Spacer()
        }
        .dismissKeyboardOnTap()
        """#
    )

    var body: some View {
        VStack(spacing: 12) {
            TextField("Type here", text: $text)
                .textFieldStyle(.roundedBorder)
                .focused($focused)
            Text("Tap empty space to dismiss the keyboard.")
                .font(.footnote)
                .foregroundStyle(.secondary)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .dismissKeyboardOnTap()
        .onChange(of: play) { _, _ in focused = true }
    }
}
