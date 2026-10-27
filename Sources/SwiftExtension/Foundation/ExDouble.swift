//  ExDouble.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import Foundation

public extension Double {
    /// The value rounded to `places` decimal places, e.g. `3.14159.rounded(toPlaces: 2)` is `3.14`.
    func rounded(toPlaces places: Int) -> Double {
        let factor = pow(10, Double(places))
        return (self * factor).rounded() / factor
    }
}
