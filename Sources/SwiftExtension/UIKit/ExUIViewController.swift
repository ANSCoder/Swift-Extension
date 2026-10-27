//
//  ExUIViewController.swift
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

public extension UIViewController {

    /// Presents an alert with a single OK button.
    ///
    /// - Parameters:
    ///   - title: The title of the alert.
    ///   - message: The message of the alert.
    func showAlertView(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    /// Deprecated misspelling of ``showAlertView(title:message:)``.
    @available(*, deprecated, renamed: "showAlertView(title:message:)")
    func showAleartViewwithTitle(_ title: String, message: String) {
        showAlertView(title: title, message: message)
    }

    /// Presents a message that dismisses itself after a delay, then calls a completion handler.
    ///
    /// ```swift
    /// showAlertWithMessage("Saved", duration: .seconds(2)) {
    ///     navigationController?.popViewController(animated: true)
    /// }
    /// ```
    ///
    /// - Important: A message that disappears on its own can be missed by people who read slowly or use VoiceOver. Use ``showAlertView(title:message:)`` for anything the user must read.
    /// - Parameters:
    ///   - message: The text of the message.
    ///   - duration: How long the message stays on screen. The default is three seconds.
    ///   - completion: A closure that runs on the main actor after the message is dismissed.
    func showAlertWithMessage(
        _ message: String,
        duration: Duration = .seconds(3),
        with completion: (@MainActor () -> Void)? = nil
    ) {
        let alert = UIAlertController(title: "Message", message: message, preferredStyle: .alert)
        present(alert, animated: true)
        Task { [weak alert] in
            try? await Task.sleep(for: duration)
            alert?.dismiss(animated: true)
            completion?()
        }
    }
}
#endif
