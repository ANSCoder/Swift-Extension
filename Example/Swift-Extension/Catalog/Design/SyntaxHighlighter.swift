//  SyntaxHighlighter.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI
import SwiftExtension

/// Minimal Swift syntax coloring for the code panels. Regex based, good enough for short snippets.
enum SyntaxHighlighter {
    /// Always-dark editor background so highlighted colors keep their contrast in both modes.
    static let background = Color(hex: "0F172A")

    private static let plain = Color(hex: "E2E8F0")
    private static let keyword = Color(hex: "C4A7FF")
    private static let type = Color(hex: "7DD3FC")
    private static let string = Color(hex: "86EFAC")
    private static let number = Color(hex: "FCD34D")
    private static let attribute = Color(hex: "F9A8D4")
    private static let comment = Color(hex: "7C8AA5")

    private static let keywords = [
        "import", "struct", "class", "enum", "extension", "protocol", "func", "var", "let", "if", "else",
        "guard", "return", "in", "some", "private", "static", "case", "switch", "for", "while", "true",
        "false", "nil", "self", "await", "try", "async", "init", "where", "throws", "any",
    ].joined(separator: "|")

    /// Returns `code` as an attributed string. Later rules win, so comments and strings override the rest.
    static func highlight(_ code: String) -> AttributedString {
        var result = AttributedString(code)
        result.font = .system(.footnote, design: .monospaced)
        result.foregroundColor = plain

        paint(#"\b[A-Z][A-Za-z0-9]*\b"#, type, in: code, on: &result)
        paint(#"@[A-Za-z]+"#, attribute, in: code, on: &result)
        paint(#"\b(?:\#(keywords))\b"#, keyword, in: code, on: &result)
        paint(#"\b\d+(?:\.\d+)?\b"#, number, in: code, on: &result)
        paint(#""(?:[^"\\\n]|\\.)*""#, string, in: code, on: &result)
        paint(#"//.*"#, comment, in: code, on: &result)
        return result
    }

    private static func paint(_ pattern: String, _ color: Color, in text: String, on result: inout AttributedString) {
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return }
        let fullRange = NSRange(text.startIndex..., in: text)
        for match in regex.matches(in: text, range: fullRange) {
            guard let range = Range(match.range, in: result) else { continue }
            result[range].foregroundColor = color
        }
    }
}
