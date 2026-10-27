//
//  ExUINavigationBar.swift
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

public extension UINavigationBar {

    /// Sets the title font and color for standard and large titles.
    func setTitleFont(_ font: UIFont, color: UIColor = .label) {
        let attributes: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: color]
        standardAppearance.titleTextAttributes = attributes
        standardAppearance.largeTitleTextAttributes = attributes
        scrollEdgeAppearance?.titleTextAttributes = attributes
        scrollEdgeAppearance?.largeTitleTextAttributes = attributes
    }

    /// Makes the navigation bar transparent with `tint` for the bar items and title.
    func makeTransparent(withTint tint: UIColor = .white) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [.foregroundColor: tint]
        appearance.largeTitleTextAttributes = [.foregroundColor: tint]
        applyAppearance(appearance)
        tintColor = tint
    }

    /// Sets an opaque background color and matching text/tint color.
    func setColors(background: UIColor, text: UIColor) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = background
        appearance.titleTextAttributes = [.foregroundColor: text]
        appearance.largeTitleTextAttributes = [.foregroundColor: text]
        applyAppearance(appearance)
        tintColor = text
    }

    private func applyAppearance(_ appearance: UINavigationBarAppearance) {
        standardAppearance = appearance
        scrollEdgeAppearance = appearance
        compactAppearance = appearance
    }
}
#endif
