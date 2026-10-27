//  KeyboardToolbarDemo.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI
import SwiftExtension

struct KeyboardToolbarDemo: View {
    let play: Int
    @State private var amount = ""
    @FocusState private var focused: Bool

    static let info = ExampleInfo(
        category: .keyboard,
        title: "Keyboard toolbar with Done",
        summary: "Decimal pads have no return key. A keyboard toolbar item gives the user a way out.",
        code: #"""
        @State private var amount = ""
        @FocusState private var focused: Bool

        TextField("Amount", text: $amount)
            .keyboardType(.decimalPad)
            .focused($focused)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") { focused = false }
                }
            }
        """#
    )

    var body: some View {
        VStack(spacing: 12) {
            TextField("Amount", text: $amount)
                .keyboardType(.decimalPad)
                .textFieldStyle(.roundedBorder)
                .focused($focused)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") { focused = false }
                    }
                }
            Text("Keyboard has no return key; Done dismisses it.")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
        .onChange(of: play) { _, _ in focused = true }
    }
}
