//
//  ExUIImage.swift
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

public extension UIImage {

    /// The image as base64-encoded PNG data.
    ///
    /// The value is `nil` when the image can't be encoded as PNG.
    var toBase64String: String? {
        pngData()?.base64EncodedString(options: .lineLength64Characters)
    }

    /// Returns a copy of the image scaled by the same factor in both dimensions.
    ///
    /// - Parameter scale: The factor to multiply the width and height by.
    /// - Returns: The scaled image.
    func resized(by scale: CGFloat) -> UIImage {
        let size = CGSize(width: self.size.width * scale, height: self.size.height * scale)
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }

    /// A copy of the image at half its width and height.
    var halfSizeImage: UIImage? { resized(by: 0.5) }

    /// A copy of the image at a quarter of its width and height.
    var quarterhalfSizeImage: UIImage? { resized(by: 0.25) }

    /// Loads an image from a file path, such as a file in the Documents directory.
    ///
    /// - Parameter path: The absolute path to the image file.
    /// - Returns: The image, or `nil` if the file can't be read or decoded.
    func loadImageFromDocumentDirPath(_ path: String) -> UIImage? {
        UIImage(contentsOfFile: path)
    }
}
#endif
