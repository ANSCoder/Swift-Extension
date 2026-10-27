//  ExEncodable.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import Foundation

public extension Encodable {
    /// Returns the value encoded as a JSON object dictionary.
    ///
    /// ```swift
    /// try ["name": "Zoë"].asDictionary()   // ["name": "Zoë"]
    /// ```
    ///
    /// - Parameter encoder: The encoder to use. The default is a new `JSONEncoder`.
    /// - Returns: The encoded object, with JSON values as the dictionary's values.
    /// - Throws: `EncodingError` if the value cannot be encoded, or if it does not encode to a JSON object.
    func asDictionary(encoder: JSONEncoder = JSONEncoder()) throws -> [String: Any] {
        let data = try encoder.encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            throw EncodingError.invalidValue(
                self, EncodingError.Context(codingPath: [], debugDescription: "Value does not encode to a JSON object."))
        }
        return dictionary
    }
}
