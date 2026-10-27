//  StackedBarsDemo.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import Charts
import SwiftUI

struct StackedBarsDemo: View {
    let play: Int
    @State private var data = ChartDatum.monthlyChannels()
    @State private var normalized = false

    static let info = ExampleInfo(
        category: .charts,
        title: "Stacked bars",
        summary: "Series stacked per month, switchable between absolute values and a 100% view.",
        code: #"""
            import Charts

            @State private var normalized = false

            Chart(data) { item in
                BarMark(
                    x: .value("Month", item.label),
                    y: .value("Sessions", item.value),
                    stacking: normalized ? .normalized : .standard
                )
                .foregroundStyle(by: .value("Channel", item.series))
                .cornerRadius(4)
            }
            .chartForegroundStyleScale(["Web": .indigo, "iOS": .teal, "Android": .orange])
            .chartLegend(position: .top, alignment: .leading)
            .animation(.smooth, value: normalized)
            """#
    )

    var body: some View {
        VStack(spacing: 12) {
            Picker("Stacking", selection: $normalized) {
                Text("Absolute").tag(false)
                Text("100%").tag(true)
            }
            .pickerStyle(.segmented)

            Chart(data) { item in
                BarMark(
                    x: .value("Month", item.label),
                    y: .value("Sessions", item.value),
                    stacking: normalized ? .normalized : .standard
                )
                .foregroundStyle(by: .value("Channel", item.series))
                .cornerRadius(4)
            }
            .chartForegroundStyleScale([
                "Web": Palette.series[0],
                "iOS": Palette.series[1],
                "Android": Palette.series[2],
            ])
            .chartLegend(position: .top, alignment: .leading, spacing: 8)
            .chartYAxis {
                AxisMarks(position: .leading, values: .automatic(desiredCount: 4)) { value in
                    AxisGridLine().foregroundStyle(Palette.stroke)
                    AxisValueLabel {
                        if let number = value.as(Double.self) {
                            Text(normalized ? "\(Int(number * 100))%" : "\(Int(number))")
                                .foregroundStyle(Palette.secondaryText)
                        }
                    }
                }
            }
            .chartXAxis {
                AxisMarks { _ in AxisValueLabel().foregroundStyle(Palette.secondaryText) }
            }
        }
        .animation(.smooth, value: normalized)
        .onChange(of: play) { _, newValue in
            withAnimation(.smooth) { data = ChartDatum.monthlyChannels(seed: newValue) }
        }
    }
}
