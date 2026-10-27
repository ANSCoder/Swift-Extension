//  ConditionalModifiersDemo.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI
import SwiftExtension

struct ConditionalModifiersDemo: View {
    let play: Int
    @State private var highlighted = false
    @State private var nickname: String?

    static let info = ExampleInfo(
        category: .modifiers,
        title: "Conditional modifiers",
        summary: "if(_:transform:), ifLet(_:transform:) and hidden(if:) apply modifiers without ternary soup.",
        code: #"""
        @State private var highlighted = false
        @State private var nickname: String?

        Text("Styled when highlighted")
            .if(highlighted) { $0.foregroundStyle(.orange).bold() }

        Text("Revealed when highlighted")
            .hidden(if: !highlighted)

        Text("Hi")
            .ifLet(nickname) { view, name in
                view.accessibilityLabel("Hi, \(name)")
            }
        """#
    )

    var body: some View {
        VStack(spacing: 16) {
            Text("Styled when highlighted")
                .font(.title3)
                .if(highlighted) { $0.foregroundStyle(.orange).bold() }

            Text("Revealed when highlighted")
                .font(.footnote)
                .hidden(if: !highlighted)

            Text(nickname.map { "Hi, \($0)" } ?? "No nickname set")
                .font(.footnote)
                .ifLet(nickname) { view, name in
                    view.accessibilityLabel("Hi, \(name)")
                }

            Button("Toggle") { apply() }
                .buttonStyle(.bordered)
        }
        .onChange(of: play) { _, _ in apply() }
    }

    private func apply() {
        withAnimation {
            highlighted.toggle()
            nickname = nickname == nil ? "Anand" : nil
        }
    }
}
