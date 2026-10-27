//  ShakeModifier.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

#if canImport(UIKit)
import SwiftUI

private struct ShakeModifier<Trigger: Equatable>: ViewModifier {
    let trigger: Trigger
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var progress: CGFloat = 0

    func body(content: Content) -> some View {
        content
            .modifier(ShakeEffect(progress: progress))
            .onChange(of: trigger) { _, _ in
                guard !reduceMotion else { return }
                withAnimation(.linear(duration: 0.4)) { progress += 1 }
            }
    }
}

public extension View {
    /// Shakes the view each time `trigger` changes. Skipped when Reduce Motion is on.
    func shake<Trigger: Equatable>(trigger: Trigger) -> some View {
        modifier(ShakeModifier(trigger: trigger))
    }
}
#endif
