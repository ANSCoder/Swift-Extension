//  SizePreferenceKey.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

#if canImport(UIKit)
import SwiftUI

struct SizePreferenceKey: PreferenceKey {
    static let defaultValue: CGSize = .zero

    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}
#endif
