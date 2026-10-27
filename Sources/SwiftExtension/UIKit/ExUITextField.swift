//
//  ExUITextField.swift
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

public extension UITextField {

    /// Draws a 1pt rounded border in `color`.
    func setBorderAndCorner(color: UIColor = UIColor(hex: "61906B")) {
        layer.borderWidth = 1
        layer.borderColor = color.cgColor
        layer.cornerRadius = 5
    }

    /// Adds `amount` points of empty space before the text, inside the field.
    func setLeftPaddingPoints(_ amount: CGFloat) {
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: frame.height))
        leftViewMode = .always
    }

    /// Adds `amount` points of empty space after the text, inside the field.
    func setRightPaddingPoints(_ amount: CGFloat) {
        rightView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: frame.height))
        rightViewMode = .always
    }

    /// `true` when the text is a valid email address.
    var isValidEmail: Bool {
        (text ?? "").isEmail
    }

    /// `true` when the text is exactly a 10-digit phone number as detected by `NSDataDetector`.
    var isPhoneNumber: Bool {
        let value = text ?? ""
        let fullRange = NSRange(value.startIndex..., in: value)
        guard value.count == 10,
            let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue),
            let match = detector.matches(in: value, options: [], range: fullRange).first
        else {
            return false
        }
        return match.resultType == .phoneNumber && match.range == fullRange
    }
}
#endif
