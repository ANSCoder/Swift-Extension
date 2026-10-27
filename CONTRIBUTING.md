# Contributing

Thanks for helping. Small, focused changes are easiest to review.

## Set up

```bash
git clone https://github.com/ANSCoder/Swift-Extension.git
cd Swift-Extension
swift build && swift test                       # Foundation helpers on macOS
open Example/Swift-Extension.xcodeproj          # catalog app
```

Full suite on a simulator:

```bash
xcodebuild test -scheme SwiftExtension -destination 'platform=iOS Simulator,name=iPhone 17'
```

## Before you open a pull request

1. Branch from `main`. Use a descriptive title like `feat: add Date.isWeekend` or `fix: ...`. The title decides the release notes category.
2. Every public declaration gets a `///` comment with a short ```swift example.
3. Behavior changes come with tests. UIKit and SwiftUI tests are `@MainActor`.
4. Run `xcrun swift-format format --in-place --recursive Sources Tests`.
5. New UI supports Dynamic Type, VoiceOver and Reduce Motion, and never signals state by color alone.
6. Add a line under **Unreleased** in `CHANGELOG.md`.
7. No third-party dependencies.

## Code rules

- Swift 6 language mode. No `@unchecked Sendable`, `nonisolated(unsafe)` or `@preconcurrency` without a written invariant and a removal plan.
- Prefer structured concurrency. No `DispatchQueue` timers, semaphores or locks.
- No force unwraps or `try!` in `Sources`.
- UIKit and SwiftUI code stays inside `#if canImport(UIKit)`. Foundation code must build on macOS.
- One type per file. Extensions of one type may share a file.

## Adding a catalog example

See "Add an example to the catalog" in the README. `CatalogTests` checks that every example is complete.

## Reviews

A pull request gets automatic checks (CI, CodeQL, Danger) and bot review (CodeRabbit, Copilot). Bots can be wrong. A maintainer makes the final call.
