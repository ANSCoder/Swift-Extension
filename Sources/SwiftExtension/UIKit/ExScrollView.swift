//
//  ExScrollView.swift
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

public extension UIScrollView {

    /// Scrolls so that the top edge of a view sits at the top of the scroll view.
    ///
    /// The view must be inside the scroll view's hierarchy. If it isn't, nothing happens.
    ///
    /// - Parameters:
    ///   - view: The view to scroll to.
    ///   - animated: Whether to animate the scroll.
    func scrollToView(view: UIView, animated: Bool) {
        guard view.superview != nil else { return }
        let top = view.convert(view.bounds, to: self).minY
        scrollRectToVisible(CGRect(x: 0, y: top, width: 1, height: bounds.height), animated: animated)
    }

    /// Scrolls to the top edge of the content, respecting insets and the safe area.
    ///
    /// - Parameter animated: Whether to animate the scroll.
    func scrollToTop(animated: Bool) {
        setContentOffset(CGPoint(x: 0, y: -adjustedContentInset.top), animated: animated)
    }

    /// Scrolls to the bottom edge of the content.
    ///
    /// Does nothing when the content fits on screen.
    ///
    /// - Parameter animated: Whether to animate the scroll. The default is `true`.
    func scrollToBottom(animated: Bool = true) {
        let offset = CGPoint(x: 0, y: contentSize.height - bounds.height + adjustedContentInset.bottom)
        guard offset.y > 0 else { return }
        setContentOffset(offset, animated: animated)
    }
}
#endif
