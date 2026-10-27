//  ExURL.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import Foundation

public extension URL {
    /// The query items as a dictionary.
    ///
    /// If a name appears more than once, the last value wins. Items without a value are omitted.
    ///
    /// ```swift
    /// URL(string: "https://swift.org?lang=en&sort=new")?.queryItems
    /// // ["lang": "en", "sort": "new"]
    /// ```
    var queryItems: [String: String] {
        let items = URLComponents(url: self, resolvingAgainstBaseURL: false)?.queryItems ?? []
        return items.reduce(into: [:]) { result, item in
            if let value = item.value { result[item.name] = value }
        }
    }

    /// Returns a copy of the URL with query items added or replaced.
    ///
    /// ```swift
    /// url.appendingQueryItems(["ref": "newsletter"])
    /// ```
    ///
    /// - Parameter items: Name and value pairs to add. An existing item with the same name is replaced.
    /// - Returns: The new URL, or the original URL if its components can't be parsed.
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
