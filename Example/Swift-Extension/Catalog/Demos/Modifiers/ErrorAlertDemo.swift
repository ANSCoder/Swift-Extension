//  ErrorAlertDemo.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI
import SwiftExtension

struct ErrorAlertDemo: View {
    let play: Int
    @State private var message: String?

    static let info = ExampleInfo(
        category: .modifiers,
        title: "Error alert from state",
        summary: "errorAlert(message:) shows an OK alert when an optional message becomes non-nil, then clears it.",
        code: #"""
        @State private var message: String?

        Button("Trigger error") {
            message = "Request timed out."
        }
        .errorAlert(message: $message)
        """#
    )

    var body: some View {
        Button("Trigger error") { message = "Demo failure: request timed out." }
            .buttonStyle(.bordered)
            .errorAlert(message: $message)
            .onChange(of: play) { _, _ in message = "Triggered by Play." }
    }
}
