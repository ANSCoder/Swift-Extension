//  DateHelpersDemo.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI
import SwiftExtension

struct DateHelpersDemo: View {
    let play: Int
    @State private var date = Date.now

    static let info = ExampleInfo(
        category: .foundation,
        title: "Date helpers",
        summary: "isToday, isSameDay(as:), adding(_:value:) and startOfDay, plus toString() / toTimeString().",
        code: #"""
        let date = Date.now

        date.isToday                          // true
        date.isSameDay(as: .now)              // true
        date.adding(.day, value: 7)?.toString()
        date.startOfDay.toTimeString()        // "00:00"
        """#
    )

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            DatePicker("Pick a date", selection: $date, displayedComponents: .date)
            Text("isToday: \(date.isToday ? "yes" : "no")")
            Text("Same day as now: \(date.isSameDay(as: .now) ? "yes" : "no")")
            Text("Plus 7 days: \(date.adding(.day, value: 7)?.toString() ?? "-")")
            Text("Start of day: \(date.startOfDay.toTimeString())")
        }
        .font(.footnote.monospacedDigit())
        .frame(maxWidth: .infinity, alignment: .leading)
        .onChange(of: play) { _, _ in
            withAnimation { date = Date.now.adding(.day, value: 1) ?? Date.now }
        }
    }
}
