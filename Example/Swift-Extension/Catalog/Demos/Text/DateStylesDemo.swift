//  DateStylesDemo.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI

struct DateStylesDemo: View {
    let play: Int
    @State private var base = Date.now

    static let info = ExampleInfo(
        category: .text,
        title: "Date text styles",
        summary: "Text(date, style:) formats and keeps relative times fresh without a timer you manage.",
        code: #"""
        let date = Date.now.addingTimeInterval(-5_400)

        Text(date, style: .relative)     // "1 hr, 30 min ago"
        Text(date, style: .date)
        Text(date, format: .dateTime.hour().minute())
        Text(Date.now, style: .timer)    // ticking counter
        """#
    )

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(base, style: .relative)
                .font(.title3.bold())
            Text(base, style: .date)
            Text(base, format: .dateTime.hour().minute())
            Text("Timer: ") + Text(base, style: .timer)
        }
        .monospacedDigit()
        .frame(maxWidth: .infinity, alignment: .leading)
        .onChange(of: play) { _, _ in
            base = Date.now.addingTimeInterval(-Double(play) * 3_600)
        }
    }
}
