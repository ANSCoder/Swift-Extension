//  ExOptional.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

public extension Optional where Wrapped == String {
    /// The wrapped string, or `""` when the value is `nil`.
    var orEmpty: String {
        self ?? ""
    }
}
