//  ChartDatum.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import Foundation

/// One labeled value, optionally belonging to a named series. Used by the bar, donut and stacked charts.
struct ChartDatum: Identifiable {
    let label: String
    let value: Double
    var series: String = ""

    var id: String { "\(series)|\(label)" }
}
