//  LineAreaChartDemo.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import Charts
import SwiftUI

struct LineAreaChartDemo: View {
    let play: Int
    @State private var points = TimeSeriesPoint.series(days: 21)
    @State private var selectedDate: Date?
    @State private var reveal: CGFloat = 1

    static let info = ExampleInfo(
        category: .charts,
        title: "Line & area chart",
        summary: "Smoothed line over a gradient area with a scrubbing tooltip. Play redraws it left to right.",
        code: #"""
            import Charts

            Chart {
                ForEach(points) { point in
                    AreaMark(x: .value("Date", point.date, unit: .day), y: .value("Visits", point.value))
                        .interpolationMethod(.catmullRom)
                        .foregroundStyle(LinearGradient(
                            colors: [Palette.accent.opacity(0.35), Palette.accent.opacity(0.02)],
                            startPoint: .top, endPoint: .bottom))
                    LineMark(x: .value("Date", point.date, unit: .day), y: .value("Visits", point.value))
                        .interpolationMethod(.catmullRom)
                        .lineStyle(StrokeStyle(lineWidth: 3, lineCap: .round))
                        .foregroundStyle(Palette.accent)
                }
            }
            .chartXSelection(value: $selectedDate)
            .chartYScale(domain: .automatic(includesZero: false))
            .mask(alignment: .leading) { Rectangle().scaleEffect(x: reveal, anchor: .leading) }
            """#
    )

    private var selectedPoint: TimeSeriesPoint? {
        guard let selectedDate else { return nil }
        return points.min {
            abs($0.date.timeIntervalSince(selectedDate)) < abs($1.date.timeIntervalSince(selectedDate))
        }
    }

    var body: some View {
        Chart {
            ForEach(points) { point in
                AreaMark(x: .value("Date", point.date, unit: .day), y: .value("Visits", point.value))
                    .interpolationMethod(.catmullRom)
                    .foregroundStyle(
                        LinearGradient(
                            colors: [Palette.accent.opacity(0.35), Palette.accent.opacity(0.02)],
                            startPoint: .top,
                            endPoint: .bottom
                        ))
                LineMark(x: .value("Date", point.date, unit: .day), y: .value("Visits", point.value))
                    .interpolationMethod(.catmullRom)
                    .lineStyle(StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
                    .foregroundStyle(Palette.accent)
            }
            if let point = selectedPoint {
                RuleMark(x: .value("Date", point.date, unit: .day))
                    .foregroundStyle(Palette.stroke)
                    .annotation(position: .top, spacing: 4, overflowResolution: .init(x: .fit(to: .chart), y: .disabled)) {
                        ChartTooltip(
                            title: point.date.formatted(.dateTime.month(.abbreviated).day()),
                            value: "\(Int(point.value)) visits"
                        )
                    }
                PointMark(x: .value("Date", point.date, unit: .day), y: .value("Visits", point.value))
                    .symbolSize(110)
                    .foregroundStyle(Palette.accent)
            }
        }
        .chartXSelection(value: $selectedDate)
        .chartYScale(domain: .automatic(includesZero: false))
        .themedChartAxes()
        .mask(alignment: .leading) {
            Rectangle().scaleEffect(x: reveal, anchor: .leading)
        }
        .task(id: play) {
            guard play > 0 else { return }
            points = TimeSeriesPoint.series(days: 21, seed: play)
            reveal = 0
            try? await Task.sleep(for: .milliseconds(60))
            guard !Task.isCancelled else { return }
            withAnimation(.easeOut(duration: 1.2)) { reveal = 1 }
        }
    }
}
