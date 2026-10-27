//  KeyframeAnimatorDemo.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI

struct KeyframeAnimatorDemo: View {
    let play: Int

    static let info = ExampleInfo(
        category: .animations,
        title: "Keyframe animator",
        summary: "KeyframeAnimator (iOS 17) plays exact keyframes per value: cubic arcs, springs, holds. Advanced control.",
        code: #"""
        KeyframeAnimator(initialValue: CGFloat(0), trigger: play) { height in
            Image(systemName: "hare.fill")
                .font(.system(size: 64))
                .offset(y: height)
        } keyframes: { _ in
            KeyframeTrack(\.self) {
                CubicKeyframe(-120, duration: 0.3)
                SpringKeyframe(0, duration: 0.5, spring: .bouncy)
            }
        }
        """#
    )

    var body: some View {
        KeyframeAnimator(initialValue: CGFloat(0), trigger: play) { height in
            Image(systemName: "hare.fill")
                .font(.system(size: 64))
                .foregroundStyle(.green)
                .offset(y: height)
        } keyframes: { _ in
            KeyframeTrack(\.self) {
                CubicKeyframe(-120, duration: 0.3)
                SpringKeyframe(0, duration: 0.5, spring: .bouncy)
            }
        }
        .frame(height: 160)
    }
}
