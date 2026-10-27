//
//  ExLabel.swift
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

public extension UILabel {

    /// Left-aligns the text.
    func setLeft() {
        textAlignment = .left
    }

    /// Right-aligns the text.
    func setRight() {
        textAlignment = .right
    }

    /// Shows `with` in the label's current font, followed by `effect` in the system font.
    func attribute(_ with: String, effect: String) {
        let baseFont: UIFont = font ?? .systemFont(ofSize: UIFont.labelFontSize)
        let result = NSMutableAttributedString(string: with, attributes: [.font: baseFont, .foregroundColor: UIColor.label])
        result.append(
            NSAttributedString(
                string: effect, attributes: [.font: UIFont.systemFont(ofSize: baseFont.pointSize), .foregroundColor: UIColor.label]))
        attributedText = result
    }

    /// Underlines the current text.
    func underline() {
        guard let textString = text else { return }
        attributedText = NSAttributedString(string: textString, attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
    }
}
#endif
