//  BarChartDemo.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import Charts
import SwiftUI

struct BarChartDemo: View {
    let play: Int
    @State private var data = ChartDatum.weekly()
    @State private var selected: String?

    static let info = ExampleInfo(
        category: .charts,
        title: "Interactive bar chart",
        summary: "Rounded gradient bars with touch selection and a tooltip. Data changes animate between values.",
        code: #"""
            import Charts

            @State private var data = ChartDatum.weekly()
            @State private var selected: String?

            Chart {
                ForEach(data) { item in
                    BarMark(x: .value("Day", item.label), y: .value("Revenue", item.value))
                        .cornerRadius(6)
                        .foregroundStyle(item.label == selected
                            ? AnyShapeStyle(Palette.brandGradient)
                            : AnyShapeStyle(Palette.accent.opacity(0.65)))
                }
                if let selected, let item = data.first(where: { $0.label == selected }) {
                    RuleMark(x: .value("Day", item.label))
                        .annotation(position: .top) { ChartTooltip(title: item.label, value: "$\(Int(item.value))K") }
                }
            }
            .chartXSelection(value: $selected)   // iOS 17
            """#
    )

    var body: some View {
        Chart {
            ForEach(data) { item in
                BarMark(x: .value("Day", item.label), y: .value("Revenue", item.value))
                    .cornerRadius(6)
                    .foregroundStyle(
                        item.label == selected
                            ? AnyShapeStyle(Palette.brandGradient)
                            : AnyShapeStyle(Palette.accent.opacity(0.65))
                    )
                    .accessibilityLabel(item.label)
                    .accessibilityValue("\(Int(item.value)) thousand dollars")
            }
            if let selected, let item = data.first(where: { $0.label == selected }) {
                RuleMark(x: .value("Day", item.label))
                    .foregroundStyle(Palette.stroke)
                    .annotation(position: .top, spacing: 4, overflowResolution: .init(x: .fit(to: .chart), y: .disabled)) {
                        ChartTooltip(title: item.label, value: "$\(Int(item.value))K")
                    }
            }
        }
        .chartXSelection(value: $selected)
        .themedChartAxes()
        .onChange(of: play) { _, newValue in
            withAnimation(.smooth) { data = ChartDatum.weekly(seed: newValue) }
        }
    }
}
