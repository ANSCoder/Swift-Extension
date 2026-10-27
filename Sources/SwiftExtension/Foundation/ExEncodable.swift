//  ExEncodable.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import Foundation

public extension Encodable {
    /// The value as a JSON object dictionary. Throws when the value does not encode to a JSON object.
    func asDictionary(encoder: JSONEncoder = JSONEncoder()) throws -> [String: Any] {
        let data = try encoder.encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            throw EncodingError.invalidValue(
                self, EncodingError.Context(codingPath: [], debugDescription: "Value does not encode to a JSON object."))
        }
        return dictionary
    }
}
