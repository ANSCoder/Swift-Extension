//  ExComparable.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

public extension Comparable {
    /// Returns the value limited to the given closed range.
    ///
    /// ```swift
    /// 15.clamped(to: 0...10)   // 10
    /// ```
    ///
    /// - Parameter range: The smallest and largest values to allow.
    /// - Returns: The value, or the nearest bound of `range` if the value falls outside it.
    func clamped(to range: ClosedRange<Self>) -> Self {
        Swift.min(Swift.max(self, range.lowerBound), range.upperBound)
    }
}
