//  ShimmerModifier.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

#if canImport(UIKit)
import SwiftUI

private struct ShimmerModifier: ViewModifier {
    let isActive: Bool
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var phase: CGFloat = -0.6

    func body(content: Content) -> some View {
        content
            .overlay {
                if isActive && !reduceMotion {
                    GeometryReader { proxy in
                        LinearGradient(
                            colors: [.clear, .white.opacity(0.6), .clear],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                        .frame(width: proxy.size.width * 0.55)
                        .offset(x: proxy.size.width * phase)
                    }
                    .mask(content)
                    .allowsHitTesting(false)
                }
            }
            .task(id: isActive) {
                phase = -0.6
                guard isActive else { return }
                try? await Task.sleep(for: .milliseconds(30))
                withAnimation(.linear(duration: 1.3).repeatForever(autoreverses: false)) {
                    phase = 1.3
                }
            }
    }
}

public extension View {
    /// Sweeps a soft highlight across the view, as in a loading skeleton.
    ///
    /// ```swift
    /// RoundedRectangle(cornerRadius: 8).fill(.gray.opacity(0.3)).shimmer(isLoading)
    /// ```
    ///
    /// The sweep is skipped when Reduce Motion is on.
    ///
    /// - Parameter isActive: Whether the highlight animates.
    /// - Returns: The view with the shimmer attached.
    func shimmer(_ isActive: Bool = true) -> some View {
        modifier(ShimmerModifier(isActive: isActive))
    }

    /// Redacts the view as a placeholder and adds a shimmer while loading.
    ///
    /// ```swift
    /// ProfileRow(user: user).redactedShimmer(isLoading)
    /// ```
    ///
    /// - Parameter isLoading: Whether the view is shown as a loading placeholder.
    /// - Returns: The redacted view with the shimmer attached while loading.
    func redactedShimmer(_ isLoading: Bool) -> some View {
        redacted(reason: isLoading ? .placeholder : [])
            .shimmer(isLoading)
    }
}
#endif
