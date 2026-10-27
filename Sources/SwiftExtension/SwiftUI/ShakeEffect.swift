//  ShakeEffect.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

#if canImport(UIKit)
import Foundation
import SwiftUI

/// Horizontal wobble driven by `progress`. One unit is two full oscillations.
struct ShakeEffect: GeometryEffect {
    var progress: CGFloat
    var amplitude: CGFloat = 10

    var animatableData: CGFloat {
        get { progress }
        set { progress = newValue }
    }

    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX: amplitude * sin(progress * .pi * 4), y: 0))
    }
}
#endif
