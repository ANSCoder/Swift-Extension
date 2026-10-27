//  ExCollection.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

public extension Collection {
    /// `true` when the collection has at least one element.
    var isNotEmpty: Bool {
        !isEmpty
    }
}

public extension Array {
    /// Splits the array into consecutive chunks of `size` elements. The last chunk may be shorter.
    func chunked(into size: Int) -> [[Element]] {
        precondition(size > 0, "chunk size must be greater than zero")
        return stride(from: 0, to: count, by: size).map { start in
            Array(self[start..<Swift.min(start + size, count)])
        }
    }
}

public extension Sequence {
    /// The elements with duplicates removed, keeping the first element for each `key`.
    func removingDuplicates<Key: Hashable>(on key: (Element) -> Key) -> [Element] {
        var seen = Set<Key>()
        return filter { seen.insert(key($0)).inserted }
    }
}
