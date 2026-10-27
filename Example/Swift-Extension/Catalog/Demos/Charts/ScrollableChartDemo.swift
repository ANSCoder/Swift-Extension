//  ScrollableChartDemo.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import Charts
import SwiftUI

struct ScrollableChartDemo: View {
    let play: Int
    private let points = TimeSeriesPoint.series(days: 90, seed: 3)
    @State private var scrollX = Calendar.current.date(byAdding: .day, value: -20, to: .now) ?? .now
    @State private var jumpedToStart = false

    static let info = ExampleInfo(
        category: .charts,
        title: "Scrollable time series",
        summary: "Two weeks visible out of 90 days. Scroll sideways; the chart reports its position (iOS 17).",
        code: #"""
        import Charts

        @State private var scrollX = Date.now

        Chart(points) { point in
            LineMark(x: .value("Date", point.date, unit: .day), y: .value("Visits", point.value))
                .interpolationMethod(.catmullRom)
        }
        .chartScrollableAxes(.horizontal)
        .chartXVisibleDomain(length: 14 * 86_400)   // seconds
        .chartScrollPosition(x: $scrollX)
        """#
    )

    private var visibleRange: String {
        let end = Calendar.current.date(byAdding: .day, value: 14, to: scrollX) ?? scrollX
        let style = Date.FormatStyle.dateTime.month(.abbreviated).day()
        return "\(scrollX.formatted(style)) – \(end.formatted(style))"
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(visibleRange)
                .font(.footnote.weight(.semibold).monospacedDigit())
                .foregroundStyle(Palette.secondaryText)
                .contentTransition(.numericText())

            Chart(points) { point in
                AreaMark(x: .value("Date", point.date, unit: .day), y: .value("Visits", point.value))
                    .interpolationMethod(.catmullRom)
                    .foregroundStyle(LinearGradient(
                        colors: [Palette.series[1].opacity(0.3), Palette.series[1].opacity(0.02)],
                        startPoint: .top,
                        endPoint: .bottom
                    ))
                LineMark(x: .value("Date", point.date, unit: .day), y: .value("Visits", point.value))
                    .interpolationMethod(.catmullRom)
                    .lineStyle(StrokeStyle(lineWidth: 2.5, lineCap: .round))
                    .foregroundStyle(Palette.series[1])
            }
            .chartScrollableAxes(.horizontal)
            .chartXVisibleDomain(length: 14 * 86_400)
            .chartScrollPosition(x: $scrollX)
            .chartYScale(domain: .automatic(includesZero: false))
            .chartXAxis {
                AxisMarks(values: .stride(by: .day, count: 3)) { _ in
                    AxisGridLine().foregroundStyle(Palette.stroke)
                    AxisValueLabel(format: .dateTime.month(.abbreviated).day())
                        .foregroundStyle(Palette.secondaryText)
                }
            }
            .chartYAxis {
                AxisMarks(position: .leading, values: .automatic(desiredCount: 4)) { _ in
                    AxisGridLine().foregroundStyle(Palette.stroke)
                    AxisValueLabel().foregroundStyle(Palette.secondaryText)
                }
            }
        }
        .onChange(of: play) { _, _ in
            jumpedToStart.toggle()
            let target = jumpedToStart ? points.first?.date : points.last.flatMap {
                Calendar.current.date(byAdding: .day, value: -14, to: $0.date)
            }
            withAnimation(.smooth(duration: 0.9)) {
                scrollX = target ?? scrollX
            }
        }
    }
}
