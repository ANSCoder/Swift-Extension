//  ViewSnapshot.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

#if canImport(UIKit)
import SwiftUI

public extension View {
    /// Renders the view into an image.
    ///
    /// ```swift
    /// let image = ReceiptView(order: order).snapshot(scale: 3)
    /// ```
    ///
    /// - Important: Call this on the main actor.
    /// - Parameter scale: The number of pixels per point in the output image.
    /// - Returns: The rendered image, or `nil` if rendering fails.
    @MainActor
    func snapshot(scale: CGFloat = 3) -> UIImage? {
        let renderer = ImageRenderer(content: self)
        renderer.scale = scale
        return renderer.uiImage
    }
}
#endif
