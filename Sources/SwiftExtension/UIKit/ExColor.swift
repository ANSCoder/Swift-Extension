//
//  ExColor.swift
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

public extension UIColor {
    /// Creates a color from `"#RRGGBB"`, `"RRGGBB"` or `"RRGGBBAA"`. Invalid input falls back to gray.
    convenience init(hex: String) {
        let value = hex.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "#", with: "")
        guard value.count == 6 || value.count == 8, value.allSatisfy(\.isHexDigit),
            let rgba = UInt64(value, radix: 16)
        else {
            self.init(white: 0.5, alpha: 1)
            return
        }
        let bits = value.count == 8 ? rgba : (rgba << 8) | 0xFF
        self.init(
            red: CGFloat((bits >> 24) & 0xFF) / 255,
            green: CGFloat((bits >> 16) & 0xFF) / 255,
            blue: CGFloat((bits >> 8) & 0xFF) / 255,
            alpha: CGFloat(bits & 0xFF) / 255
        )
    }

    /// The color as `#RRGGBB`. Alpha is dropped and each component is rounded to 8 bits.
    var hexString: String {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        func byte(_ component: CGFloat) -> UInt8 {
            UInt8(clamping: Int((component * 255).rounded()))
        }
        return String(format: "#%02X%02X%02X", byte(red), byte(green), byte(blue))
    }
}
#endif
