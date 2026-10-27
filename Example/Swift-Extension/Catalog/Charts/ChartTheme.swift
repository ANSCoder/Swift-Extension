//  ChartTheme.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import Charts
import SwiftUI

extension View {
    /// Applies the catalog's quiet axis style: light grid on Y, secondary-colored labels.
    func themedChartAxes() -> some View {
        self
            .chartYAxis {
                AxisMarks(position: .leading, values: .automatic(desiredCount: 4)) { _ in
                    AxisGridLine().foregroundStyle(Palette.stroke)
                    AxisValueLabel().foregroundStyle(Palette.secondaryText)
                }
            }
            .chartXAxis {
                AxisMarks { _ in
                    AxisValueLabel().foregroundStyle(Palette.secondaryText)
                }
            }
    }
}
