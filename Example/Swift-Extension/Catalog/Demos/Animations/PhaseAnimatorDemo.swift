//  PhaseAnimatorDemo.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI

struct PhaseAnimatorDemo: View {
    let play: Int

    static let info = ExampleInfo(
        category: .animations,
        title: "Phase animator",
        summary: "PhaseAnimator steps through a list of phases (iOS 17). Multi-step motion with no state machine.",
        code: #"""
        PhaseAnimator([false, true, false], trigger: play) { up in
            Image(systemName: "paperplane.fill")
                .font(.system(size: 56))
                .offset(y: up ? -60 : 0)
                .scaleEffect(up ? 1.2 : 1)
        } animation: { up in
            up ? .bouncy : .smooth
        }
        """#
    )

    var body: some View {
        PhaseAnimator([false, true, false], trigger: play) { up in
            Image(systemName: "paperplane.fill")
                .font(.system(size: 56))
                .foregroundStyle(.blue)
                .offset(y: up ? -60 : 0)
                .scaleEffect(up ? 1.2 : 1)
        } animation: { up in
            up ? .bouncy : .smooth
        }
        .frame(height: 140)
    }
}
