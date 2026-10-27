//  StringHelpersDemo.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI
import SwiftExtension

struct StringHelpersDemo: View {
    let play: Int
    @State private var input = "  anand nimje  "

    static let info = ExampleInfo(
        category: .foundation,
        title: "String helpers",
        summary: "trim, firstLetterCapitalized, initials, removeSpace and isValidURL.",
        code: #"""
            "  anand nimje  ".trim                  // "anand nimje  "
            "anand nimje".firstLetterCapitalized   // "Anand nimje"
            "Anand Nimje".initials                 // "AN"
            "https://swift.org".isValidURL         // true
            "swift.org".isValidURL                 // false
            """#
    )

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            TextField("Input", text: $input)
                .textFieldStyle(.roundedBorder)
            Group {
                Text("trim: \"\(input.trim)\"")
                Text("capitalized: \(input.trim.firstLetterCapitalized)")
                Text("initials: \(input.initials)")
                Text("no spaces: \(input.removeSpace)")
                Text("valid URL: \(input.isValidURL ? "yes" : "no")")
            }
            .font(.footnote.monospacedDigit())
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .onChange(of: play) { _, _ in
            withAnimation { input = "https://swift.org" }
        }
    }
}
