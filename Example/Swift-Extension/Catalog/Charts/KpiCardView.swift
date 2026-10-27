//  KpiCardView.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import Charts
import SwiftUI

/// Compact KPI card: title, value, change badge and a sparkline.
struct KpiCardView: View {
    let metric: KpiMetric

    private var isPositive: Bool { metric.delta >= 0 }

    var body: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text(metric.title)
                    .font(.caption)
                    .foregroundStyle(Palette.secondaryText)
                Text(metric.value)
                    .font(.title3.bold().monospacedDigit())
                    .contentTransition(.numericText())
                Label {
                    Text(abs(metric.delta) / 100, format: .percent.precision(.fractionLength(1)))
                } icon: {
                    Image(systemName: isPositive ? "arrow.up.right" : "arrow.down.right")
                }
                .font(.caption2.weight(.bold))
                .foregroundStyle(isPositive ? Palette.positive : Palette.negative)
            }
            Spacer(minLength: 0)
            sparkline
                .frame(width: 92, height: 44)
        }
        .padding(12)
        .background(Palette.surface, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .strokeBorder(Palette.stroke)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(metric.title) \(metric.value), \(isPositive ? "up" : "down") \(String(format: "%.1f", abs(metric.delta))) percent")
    }

    private var sparkline: some View {
        let color = isPositive ? Palette.positive : Palette.negative
        return Chart {
            ForEach(Array(metric.trend.enumerated()), id: \.offset) { index, value in
                AreaMark(x: .value("Day", index), y: .value("Value", value))
                    .interpolationMethod(.catmullRom)
                    .foregroundStyle(LinearGradient(colors: [color.opacity(0.3), color.opacity(0)], startPoint: .top, endPoint: .bottom))
                LineMark(x: .value("Day", index), y: .value("Value", value))
                    .interpolationMethod(.catmullRom)
                    .lineStyle(StrokeStyle(lineWidth: 2, lineCap: .round))
                    .foregroundStyle(color)
            }
        }
        .chartXAxis(.hidden)
        .chartYAxis(.hidden)
        .chartYScale(domain: .automatic(includesZero: false))
        .accessibilityHidden(true)
    }
}
