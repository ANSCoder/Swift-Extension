//
//  ExNSMutableAttributedString.swift
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

#if canImport(UIKit)
import UIKit

public extension NSMutableAttributedString {

    /// Appends text in a medium weight, scaled to the user's current text size.
    ///
    /// The font is Avenir Next Medium when available, and the system medium weight otherwise.
    ///
    /// - Parameters:
    ///   - text: The text to append.
    ///   - size: The base point size, before scaling for Dynamic Type.
    /// - Returns: The same string, for chaining.
    @discardableResult
    func bold(_ text: String, size: CGFloat = 12) -> NSMutableAttributedString {
        let base = UIFont(name: "AvenirNext-Medium", size: size) ?? .systemFont(ofSize: size, weight: .medium)
        append(NSAttributedString(string: text, attributes: [.font: UIFontMetrics.default.scaledFont(for: base)]))
        return self
    }

    /// Appends text with the default attributes.
    ///
    /// - Parameter text: The text to append.
    /// - Returns: The same string, for chaining.
    @discardableResult
    func normal(_ text: String) -> NSMutableAttributedString {
        append(NSAttributedString(string: text))
        return self
    }
}
#endif
