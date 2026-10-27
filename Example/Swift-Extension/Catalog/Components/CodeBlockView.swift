//  CodeBlockView.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI
import SwiftExtension

/// Syntax-highlighted, selectable code with a copy button.
struct CodeBlockView: View {
    let code: String
    @State private var copied = false

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Label("Swift", systemImage: "chevron.left.forwardslash.chevron.right")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(Color(hex: "94A3B8"))
                Spacer()
                Button {
                    UIPasteboard.general.string = code
                    copied = true
                } label: {
                    Label(copied ? "Copied" : "Copy", systemImage: copied ? "checkmark" : "doc.on.doc")
                        .font(.caption.weight(.semibold))
                }
                .foregroundStyle(copied ? Color(hex: "86EFAC") : Color(hex: "CBD5E1"))
                .sensoryFeedback(.success, trigger: copied) { _, isCopied in isCopied }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)

            Divider().overlay(Color.white.opacity(0.08))

            ScrollView(.horizontal) {
                Text(SyntaxHighlighter.highlight(code))
                    .textSelection(.enabled)
                    .fixedSize()
                    .padding(16)
            }
        }
        .background(SyntaxHighlighter.background, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
        .task(id: copied) {
            guard copied else { return }
            try? await Task.sleep(for: .seconds(2))
            copied = false
        }
    }
}
