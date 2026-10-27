//
//  ExFunction.swift
//  Swift-Extensionn
//
//  Created by Anand Nimje on 27/01/18.
//  Copyright © 2018 Anand. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation
#if canImport(UIKit)
import UIKit
#endif

/// Helpers for converting between JSON strings and dictionaries.
///
/// Prefer `Codable` and `Encodable.asDictionary(encoder:)` in new code.
public enum ExFunction {

    /// Parses a JSON object string into a dictionary.
    ///
    /// - Parameter json: A UTF-8 string that contains a JSON object.
    /// - Returns: The parsed object, or an empty dictionary if the input isn't a JSON object.
    public static func convertStringToDictionary(_ json: String) -> [String: Any] {
        guard let data = json.data(using: .utf8),
            let object = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
        else {
            return [:]
        }
        return object
    }

    /// Serializes a dictionary into a JSON string.
    ///
    /// - Parameter dictionary: A dictionary whose keys and values are valid JSON types.
    /// - Returns: The JSON text, or an empty string if serialization fails.
    public static func getRawJSON(from dictionary: [String: Any]) -> String {
        guard let data = try? JSONSerialization.data(withJSONObject: dictionary),
            let string = String(data: data, encoding: .utf8)
        else {
            return ""
        }
        return string
    }

    #if canImport(UIKit)
    /// Creates a color from a hexadecimal string.
    ///
    /// Prefer `UIColor(hex:)` in new code.
    ///
    /// - Parameter hex: A string in the form `RRGGBB`, `#RRGGBB`, or `RRGGBBAA`.
    /// - Returns: The color. Invalid input returns gray.
    public static func hexStringToUIColor(hex: String) -> UIColor {
        UIColor(hex: hex)
    }
    #endif
}
