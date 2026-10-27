//  ExBundle.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import Foundation

public extension Bundle {
    /// The marketing version (`CFBundleShortVersionString`), or `"0"` when it is missing.
    var appVersion: String {
        object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "0"
    }

    /// The build number (`CFBundleVersion`), or `"0"` when it is missing.
    var buildNumber: String {
        object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "0"
    }
}
