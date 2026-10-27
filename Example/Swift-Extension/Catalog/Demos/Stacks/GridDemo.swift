//  GridDemo.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI

struct GridDemo: View {
    let play: Int
    @State private var quantity = 1
    private let price = 12.5

    static let info = ExampleInfo(
        category: .stacks,
        title: "Grid & GridRow",
        summary: "Table-like layout with shared column widths (iOS 16). Use for forms and labels.",
        code: #"""
        @State private var quantity = 1

        Grid(alignment: .leading, horizontalSpacing: 12, verticalSpacing: 8) {
            GridRow {
                Text("Price")
                Text("$12.50")
            }
            GridRow {
                Text("Quantity")
                Stepper("\(quantity)", value: $quantity, in: 1...9)
            }
            Divider().gridCellColumns(2)
            GridRow {
                Text("Total").bold()
                Text((12.5 * Double(quantity)), format: .currency(code: "USD"))
            }
        }
        """#
    )

    var body: some View {
        Grid(alignment: .leading, horizontalSpacing: 16, verticalSpacing: 10) {
            GridRow {
                Text("Price")
                Text(price, format: .currency(code: "USD"))
            }
            GridRow {
                Text("Quantity")
                Stepper("\(quantity)", value: $quantity, in: 1...9)
            }
            Divider()
                .gridCellColumns(2)
            GridRow {
                Text("Total").bold()
                Text(price * Double(quantity), format: .currency(code: "USD"))
                    .contentTransition(.numericText(value: price * Double(quantity)))
            }
        }
        .onChange(of: play) { _, _ in
            withAnimation { quantity = quantity == 9 ? 1 : quantity + 1 }
        }
    }
}
