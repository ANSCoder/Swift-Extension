//  KpiCardsDemo.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI

struct KpiCardsDemo: View {
    let play: Int
    @State private var metrics = KpiMetric.samples()

    static let info = ExampleInfo(
        category: .charts,
        title: "KPI cards with sparklines",
        summary: "Headline number, change badge and a hidden-axis sparkline. Direction is shown by arrow, not only color.",
        code: #"""
            struct KpiMetric: Identifiable {
                let title: String
                let value: String
                let delta: Double      // percent vs previous period
                let trend: [Double]
                var id: String { title }
            }

            // Sparkline: a Chart with both axes hidden
            Chart {
                ForEach(Array(metric.trend.enumerated()), id: \.offset) { index, value in
                    LineMark(x: .value("Day", index), y: .value("Value", value))
                        .interpolationMethod(.catmullRom)
                }
            }
            .chartXAxis(.hidden)
            .chartYAxis(.hidden)
            .chartYScale(domain: .automatic(includesZero: false))
            """#
    )

    var body: some View {
        VStack(spacing: 8) {
            ForEach(metrics) { metric in
                KpiCardView(metric: metric)
            }
        }
        .onChange(of: play) { _, newValue in
            withAnimation(.smooth) { metrics = KpiMetric.samples(seed: newValue) }
        }
    }
}
