# Changelog

All notable changes are documented here. The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and the project uses [Semantic Versioning](https://semver.org/).

## [Unreleased]

### Added

- Swift package `SwiftExtension` with a public, DocC-documented API. Swift 6 language mode, iOS 17+, macOS 14+ for the Foundation helpers.
- SwiftUI: `shake(trigger:)`, `shimmer(_:)`, `redactedShimmer(_:)`, `snapshot(scale:)`, `roundedBorder(_:width:cornerRadius:)`, `Color(hex:)`.
- Foundation: `chunked(into:)`, `removingDuplicates(on:)`, `clamped(to:)`, `rounded(toPlaces:)`, `orEmpty`, `asDictionary()`, `isValidURL`, `initials`, `truncated(to:)`, URL query helpers, `Bundle.appVersion`, and calendar helpers on `Date`.
- UIKit: `UIColor.hexString`, `UIView.addSubviews(_:)`, `UIView.pinToEdges(of:insets:)`.
- Catalog app with 56 live examples, and unit tests (87% coverage of the library).
- CI, CodeQL, Dependabot, release drafting, Danger, labeler, and review-bot configuration.

### Changed

- `Date.toString()` and `toTimeString()` use value-type format styles instead of shared `DateFormatter` instances.
- `UIViewController.showAlertWithMessage` waits with a main-actor `Task` and takes a `duration`.
- `dismissKeyboardOnTap()` is marked unavailable in app extensions.
- `changeDate(_:)` and `UIImage.toBase64String` return optionals.
- `ExFunction` is an `enum` namespace.

### Deprecated

- `showAleartViewwithTitle(_:message:)`, use `showAlertView(title:message:)`.
- `setCornerRadious()`, use `setCornerRadius()`.

### Fixed

- `UIColor(hex:)` accepts `#`, validates hex digits and supports alpha.
- `getRawJSON(from:)` no longer drops non-ASCII text.
- Force unwraps that could crash were removed.
