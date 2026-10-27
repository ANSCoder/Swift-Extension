# Review instructions

This is a Swift package of small extensions for Foundation, UIKit and SwiftUI. Review for:

- **Concurrency (Swift 6 mode).** No `@unchecked Sendable`, `nonisolated(unsafe)` or `@preconcurrency` without a written invariant. Prefer structured concurrency. No `DispatchQueue` timers or semaphores. UI code is `@MainActor`.
- **Public API.** Every public declaration has a `///` comment with a short example. Names follow the Swift API Design Guidelines. No breaking change without a `breaking` label and a CHANGELOG entry.
- **Safety.** No force unwraps, `try!` or `fatalError` in `Sources`. Inputs at boundaries are validated.
- **Accessibility.** New UI supports Dynamic Type, VoiceOver and Reduce Motion, and never signals state by color alone.
- **Platforms.** UIKit and SwiftUI code stays inside `#if canImport(UIKit)`. Foundation code must build on macOS.
- **Dependencies.** No third-party dependencies.
- **Tests.** Behavior changes come with tests.
