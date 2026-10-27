//  DonutChartDemo.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import Charts
import SwiftUI

struct DonutChartDemo: View {
    let play: Int
    @State private var data = ChartDatum.marketShare()
    @State private var angleSelection: Double?

    static let info = ExampleInfo(
        category: .charts,
        title: "Donut chart with selection",
        summary: "SectorMark (iOS 17) with rounded segments, angle selection and a live center label.",
        code: #"""
        import Charts

        @State private var angleSelection: Double?

        Chart(data) { item in
            SectorMark(
                angle: .value("Share", item.value),
                innerRadius: .ratio(0.62),
                angularInset: 2
            )
            .cornerRadius(6)
            .foregroundStyle(by: .value("Source", item.label))
            .opacity(selected == nil || selected?.label == item.label ? 1 : 0.35)
        }
        .chartAngleSelection(value: $angleSelection)   // iOS 17
        .chartLegend(.hidden)
        """#
    )

    private var total: Double { data.reduce(0) { $0 + $1.value } }

    private var selected: ChartDatum? {
        guard let angleSelection else { return nil }
        var running = 0.0
        for item in data {
            running += item.value
            if angleSelection <= running { return item }
        }
        return nil
    }

    var body: some View {
        VStack(spacing: 12) {
            Chart(data) { item in
                SectorMark(angle: .value("Share", item.value), innerRadius: .ratio(0.62), angularInset: 2)
                    .cornerRadius(6)
                    .foregroundStyle(by: .value("Source", item.label))
                    .opacity(selected == nil || selected?.label == item.label ? 1 : 0.35)
                    .accessibilityLabel(item.label)
                    .accessibilityValue("\(Int(item.value / total * 100)) percent")
            }
            .chartAngleSelection(value: $angleSelection)
            .chartForegroundStyleScale(domain: data.map(\.label), range: Array(Palette.series.prefix(data.count)))
            .chartLegend(.hidden)
            .overlay {
                VStack(spacing: 2) {
                    Text(selected?.label ?? "All sources")
                        .font(.caption)
                        .foregroundStyle(Palette.secondaryText)
                    Text((selected?.value ?? total) / total, format: .percent.precision(.fractionLength(0)))
                        .font(.title2.bold().monospacedDigit())
                        .contentTransition(.numericText())
                }
            }
            .frame(height: 190)

            FlowLayout(spacing: 10) {
                ForEach(Array(data.enumerated()), id: \.element.id) { index, item in
                    HStack(spacing: 5) {
                        Circle().fill(Palette.series[index % Palette.series.count]).frame(width: 8, height: 8)
                        Text(item.label).font(.caption)
                    }
                }
            }
        }
        .animation(.smooth, value: selected?.label)
        .onChange(of: play) { _, newValue in
            withAnimation(.smooth) { data = ChartDatum.marketShare(seed: newValue) }
        }
    }
}
