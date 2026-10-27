//  ExBundle.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import Foundation

public extension Bundle {
    /// The marketing version of the app, read from `CFBundleShortVersionString`.
    ///
    /// Returns `"0"` when the key is missing, for example in a test bundle without an Info.plist.
    var appVersion: String {
        object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "0"
    }

    /// The build number of the app, read from `CFBundleVersion`.
    ///
    /// Returns `"0"` when the key is missing.
    var buildNumber: String {
        object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "0"
    }
}
