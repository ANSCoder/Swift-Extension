//  ExComparable.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

public extension Comparable {
    /// The value limited to `range`, e.g. `15.clamped(to: 0...10)` is `10`.
    func clamped(to range: ClosedRange<Self>) -> Self {
        Swift.min(Swift.max(self, range.lowerBound), range.upperBound)
    }
}
