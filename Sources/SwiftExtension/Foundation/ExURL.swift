//  ExURL.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import Foundation

public extension URL {
    /// The query as a dictionary. When a name repeats, the last value wins.
    ///
    /// ```swift
    /// URL(string: "https://swift.org/docs?lang=en&sort=new")?.queryItems
    /// // ["lang": "en", "sort": "new"]
    /// ```
    var queryItems: [String: String] {
        let items = URLComponents(url: self, resolvingAgainstBaseURL: false)?.queryItems ?? []
        return items.reduce(into: [:]) { result, item in
            if let value = item.value { result[item.name] = value }
        }
    }

    /// A copy with `items` added to the query. Existing names are replaced.
    ///
    /// ```swift
    /// url.appendingQueryItems(["ref": "newsletter"])
    /// ```
    func appendingQueryItems(_ items: [String: String]) -> URL {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: false) else { return self }
        var merged = components.queryItems ?? []
        for (name, value) in items.sorted(by: { $0.key < $1.key }) {
            merged.removeAll { $0.name == name }
            merged.append(URLQueryItem(name: name, value: value))
        }
        components.queryItems = merged
        return components.url ?? self
    }
}
