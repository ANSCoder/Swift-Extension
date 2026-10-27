//  ExCollection.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

public extension Collection {
    /// A Boolean value that indicates whether the collection has at least one element.
    var isNotEmpty: Bool {
        !isEmpty
    }
}

public extension Array {
    /// Splits the array into consecutive chunks of the given size.
    ///
    /// The last chunk holds the remainder and can be shorter than `size`.
    ///
    /// ```swift
    /// [1, 2, 3, 4, 5].chunked(into: 2)   // [[1, 2], [3, 4], [5]]
    /// ```
    ///
    /// - Parameter size: The number of elements in each chunk. Must be greater than zero.
    /// - Returns: The chunks, in their original order.
    func chunked(into size: Int) -> [[Element]] {
        precondition(size > 0, "chunk size must be greater than zero")
        return stride(from: 0, to: count, by: size).map { start in
            Array(self[start..<Swift.min(start + size, count)])
        }
    }
}

public extension Sequence {
    /// Returns the elements with duplicates removed, keeping the first element for each key.
    ///
    /// ```swift
    /// ["Swift", "swift", "SwiftUI"].removingDuplicates(on: { $0.lowercased() })
    /// // ["Swift", "SwiftUI"]
    /// ```
    ///
    /// - Parameter key: A closure that returns the value used to detect duplicates.
    /// - Returns: The unique elements, in their original order.
    func removingDuplicates<Key: Hashable>(on key: (Element) -> Key) -> [Element] {
        var seen = Set<Key>()
        return filter { seen.insert(key($0)).inserted }
    }
}
