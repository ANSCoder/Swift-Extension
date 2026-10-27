//  FocusChainDemo.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI
import SwiftExtension

struct FocusChainDemo: View {
    let play: Int
    @State private var first = ""
    @State private var last = ""
    @State private var email = ""
    @FocusState private var focusedField: Int?

    static let info = ExampleInfo(
        category: .keyboard,
        title: "Focus chain",
        summary: "@FocusState plus submitLabel(.next) moves focus field to field, like a login form.",
        code: #"""
        @FocusState private var focusedField: Int?

        TextField("First", text: $first)
            .focused($focusedField, equals: 0)
            .submitLabel(.next)
            .onSubmit { focusedField = 1 }

        TextField("Last", text: $last)
            .focused($focusedField, equals: 1)
            .submitLabel(.next)
            .onSubmit { focusedField = 2 }

        TextField("Email", text: $email)
            .focused($focusedField, equals: 2)
            .submitLabel(.done)
            .onSubmit { focusedField = nil }
        """#
    )

    var body: some View {
        VStack(spacing: 12) {
            TextField("First name", text: $first)
                .focused($focusedField, equals: 0)
                .submitLabel(.next)
                .onSubmit { focusedField = 1 }
            TextField("Last name", text: $last)
                .focused($focusedField, equals: 1)
                .submitLabel(.next)
                .onSubmit { focusedField = 2 }
            TextField("Email", text: $email)
                .focused($focusedField, equals: 2)
                .submitLabel(.done)
                .onSubmit { focusedField = nil }
        }
        .textFieldStyle(.roundedBorder)
        .onChange(of: play) { _, _ in focusedField = 0 }
    }
}
