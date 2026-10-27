//  ExDouble.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import Foundation

public extension Double {
    /// Returns the value rounded to a number of decimal places.
    ///
    /// ```swift
    /// 3.14159.rounded(toPlaces: 2)   // 3.14
    /// ```
    ///
    /// Halfway values round away from zero.
    ///
    /// - Parameter places: The number of decimal places to keep.
    /// - Returns: The rounded value.
    func rounded(toPlaces places: Int) -> Double {
        let factor = pow(10, Double(places))
        return (self * factor).rounded() / factor
    }
}
