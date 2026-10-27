//  ExampleCategory.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI
import SwiftExtension

enum ExampleCategory: String, CaseIterable, Identifiable {
    case scroll, keyboard, stacks, text, animations, charts, modifiers, foundation

    var id: Self { self }

    var title: String {
        switch self {
        case .scroll: "Scroll"
        case .keyboard: "Keyboard"
        case .stacks: "Stacks & Layout"
        case .text: "Text"
        case .animations: "Animations"
        case .charts: "Charts"
        case .modifiers: "View Modifiers"
        case .foundation: "Foundation"
        }
    }

    var symbol: String {
        switch self {
        case .scroll: "arrow.up.and.down"
        case .keyboard: "keyboard"
        case .stacks: "square.stack.3d.up"
        case .text: "textformat"
        case .animations: "sparkles"
        case .charts: "chart.xyaxis.line"
        case .modifiers: "slider.horizontal.3"
        case .foundation: "function"
        }
    }

    /// Accent color for the category. Dark enough for white symbols.
    var tint: Color {
        switch self {
        case .scroll: Color(hex: "2563EB")
        case .keyboard: Color(hex: "0D9488")
        case .stacks: Color(hex: "EA580C")
        case .text: Color(hex: "DB2777")
        case .animations: Color(hex: "7C3AED")
        case .charts: Color(hex: "059669")
        case .modifiers: Color(hex: "D97706")
        case .foundation: Color(hex: "475569")
        }
    }
}
