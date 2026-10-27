//  URLHelpersDemo.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI
import SwiftExtension

struct URLHelpersDemo: View {
    let play: Int
    @State private var urlText = "https://swift.org/docs?lang=en&sort=new"

    static let info = ExampleInfo(
        category: .foundation,
        title: "URL & Bundle helpers",
        summary: "queryItems reads a query as a dictionary, appendingQueryItems merges new ones, Bundle gives version and build.",
        code: #"""
        let url = URL(string: "https://swift.org/docs?lang=en&sort=new")!

        url.queryItems                                  // ["lang": "en", "sort": "new"]
        url.appendingQueryItems(["ref": "newsletter"])  // ...&ref=newsletter

        Bundle.main.appVersion    // "1.0"
        Bundle.main.buildNumber   // "1"
        """#
    )

    private var items: [(key: String, value: String)] {
        URL(string: urlText)?.queryItems.sorted { $0.key < $1.key } ?? []
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            TextField("URL", text: $urlText)
                .textFieldStyle(.roundedBorder)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()

            if URL(string: urlText) == nil {
                Label("Not a valid URL", systemImage: "exclamationmark.triangle")
                    .font(.footnote)
                    .foregroundStyle(Palette.secondaryText)
            } else if items.isEmpty {
                Text("No query items")
                    .font(.footnote)
                    .foregroundStyle(Palette.secondaryText)
            } else {
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(items, id: \.key) { item in
                        HStack {
                            Text(item.key).bold()
                            Text(item.value).foregroundStyle(Palette.secondaryText)
                        }
                        .font(.footnote.monospaced())
                    }
                }
            }

            Divider()
            Text("App \(Bundle.main.appVersion) (build \(Bundle.main.buildNumber))")
                .font(.footnote.monospacedDigit())
                .foregroundStyle(Palette.secondaryText)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .onChange(of: play) { _, newValue in
            if let url = URL(string: urlText) {
                withAnimation { urlText = url.appendingQueryItems(["ref": "play\(newValue)"]).absoluteString }
            }
        }
    }
}
