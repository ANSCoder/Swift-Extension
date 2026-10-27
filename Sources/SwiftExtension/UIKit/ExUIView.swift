//  ExUIView.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

#if canImport(UIKit)
import UIKit

public extension UIView {

    /// Adds each view as a subview.
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }

    /// Adds the view to `superview` if needed, then pins its edges to the superview's, inset by `insets`. Leading and trailing follow the layout direction.
    func pinToEdges(of superview: UIView, insets: NSDirectionalEdgeInsets = .zero) {
        if self.superview !== superview {
            superview.addSubview(self)
        }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: insets.leading),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -insets.trailing),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -insets.bottom),
        ])
    }
}
#endif
