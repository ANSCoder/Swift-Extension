//  ExSwiftUIColor.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

#if canImport(UIKit)
import SwiftUI
import UIKit

public extension Color {

    /// Creates a color from a hexadecimal string.
    ///
    /// ```swift
    /// Color(hex: "#61906B")
    /// ```
    ///
    /// - Parameter hex: A string in the form `RRGGBB`, `#RRGGBB`, or `RRGGBBAA`. Invalid input produces gray.
    init(hex: String) {
        self.init(uiColor: UIColor(hex: hex))
    }
}
#endif
