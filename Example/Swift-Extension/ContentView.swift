//  ContentView.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI

/// Catalog root: hero banner, category filter, search, and every example grouped by category.
struct ContentView: View {
    @State private var selection: ExampleCategory?
    @State private var query = ""

    var body: some View {
        if let example = launchExample(for: "example") {
            RecordingStage(example: example)
        } else if let example = launchExample(for: "detail") {
            NavigationStack { ExampleDetailView(example: example) }
                .tint(Palette.accent)
        } else {
            catalog
        }
    }

    private var catalog: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    HeroHeaderView(exampleCount: Example.allCases.count, categoryCount: ExampleCategory.allCases.count)
                        .padding(.horizontal, 20)

                    CategoryFilterBar(selection: $selection)

                    LazyVStack(alignment: .leading, spacing: 28) {
                        ForEach(ExampleCategory.allCases) { category in
                            let examples = visibleExamples(in: category)
                            if !examples.isEmpty {
                                ExampleSectionView(category: category, examples: examples)
                            }
                        }
                        if visibleExamples.isEmpty {
                            ContentUnavailableView.search(text: query)
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.bottom, 32)
            }
            .background(Palette.background)
            .navigationTitle("Swift Extension")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $query, prompt: "Search \(Example.allCases.count) examples")
            .navigationDestination(for: Example.self) { example in
                ExampleDetailView(example: example)
            }
        }
        .tint(Palette.accent)
    }

    private var visibleExamples: [Example] {
        Example.allCases.filter { example in
            let matchesCategory = selection == nil || example.info.category == selection
            let matchesQuery = query.isEmpty
                || example.info.title.localizedCaseInsensitiveContains(query)
                || example.info.summary.localizedCaseInsensitiveContains(query)
            return matchesCategory && matchesQuery
        }
    }

    private func visibleExamples(in category: ExampleCategory) -> [Example] {
        visibleExamples.filter { $0.info.category == category }
    }

    /// Reads a launch argument such as `-example confetti` or `-detail barChart`.
    /// `example` shows the bare auto-playing stage (GIF recording); `detail` opens one example screen (screenshots).
    private func launchExample(for key: String) -> Example? {
        guard let name = UserDefaults.standard.string(forKey: key) else { return nil }
        return Example.allCases.first { String(describing: $0) == name }
    }
}

#Preview {
    ContentView()
}
