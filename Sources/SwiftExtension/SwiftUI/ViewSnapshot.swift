//  ViewSnapshot.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

#if canImport(UIKit)
import SwiftUI

public extension View {
    /// Renders the view into an image with `ImageRenderer`.
    ///
    /// ```swift
    /// let image = ReceiptView(order: order).snapshot(scale: 3)
    /// ```
    /// - Parameter scale: Pixels per point. Use 3 for the sharpest result on current iPhones.
    /// - Returns: The rendered image, or `nil` when the view has no size.
    @MainActor
    func snapshot(scale: CGFloat = 3) -> UIImage? {
        let renderer = ImageRenderer(content: self)
        renderer.scale = scale
        return renderer.uiImage
    }
}
#endif
