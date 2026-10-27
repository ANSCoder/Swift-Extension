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
    /// Shakes the view each time the trigger value changes.
    ///
    /// ```swift
    /// Text("Wrong password").shake(trigger: attempts)
    /// ```
    ///
    /// The shake is skipped when Reduce Motion is on.
    ///
    /// - Parameter trigger: A value that starts a shake when it changes.
    /// - Returns: The view with the shake effect attached.
    func shake<Trigger: Equatable>(trigger: Trigger) -> some View {
        modifier(ShakeModifier(trigger: trigger))
    }
}
#endif
