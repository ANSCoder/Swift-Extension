//  ExSwiftUIColor.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

#if canImport(UIKit)
import SwiftUI
import UIKit

public extension Color {

    /// Creates a color from `"#RRGGBB"`, `"RRGGBB"` or `"RRGGBBAA"`. Invalid input falls back to gray.
    init(hex: String) {
        self.init(uiColor: UIColor(hex: hex))
    }
}
#endif
