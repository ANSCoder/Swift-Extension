## Summary

Turns the repository into a Swift package, `SwiftExtension`, ready for Swift Package Manager, and adds production CI, review bots, and documentation. The catalog app now lives in `Example/` and consumes the local package.

## What changed

**Package**
- `Package.swift` with tools 6.0, Swift 6 language mode, iOS 17+ and macOS 14+ (Foundation helpers only).
- Sources in `Sources/SwiftExtension/{Foundation,UIKit,SwiftUI}`, tests in `Tests/SwiftExtensionTests`.
- Public, DocC-documented API. UIKit and SwiftUI code sits behind `#if canImport(UIKit)`, so `swift build` works on macOS.
- 14 new helpers (`chunked`, `removingDuplicates`, `clamped`, `shimmer`, `snapshot`, URL and Bundle helpers, and more), each with tests.

**Concurrency**
- `showAlertWithMessage` waits with a main-actor `Task` and takes a `duration`. It replaces an uncancellable `DispatchQueue` timer.
- `Date.toString()` and `toTimeString()` use value-type `FormatStyle`s instead of shared `DateFormatter`s.
- Demo screens use `.task(id:)` so async work is cancelled when the view goes away.
- No `@unchecked Sendable`, `nonisolated(unsafe)`, `@preconcurrency`, locks, or semaphores. No force unwraps in `Sources`.

**Catalog app** (`Example/`)
- Redesigned UI: hero banner, category filter, search, and a detail screen with a live stage, Play button, and syntax-highlighted code.
- 56 examples, including 6 chart examples and 20 animation examples.
- README GIFs and screenshots are generated from the app with launch arguments (`-example`, `-detail`).

**CI and automation**
- `ci.yml`: swift-format, macOS build and test, iOS simulator tests with coverage, example app, DocC build. Warnings are errors. One aggregate check, `CI success`.
- `codeql.yml`, `release.yml` (runs on tags), `dependabot.yml`, `stale.yml`, `labeler.yml`, `release-drafter.yml`.
- Review bots: `dangerfile.js` (PR hygiene checks), `.coderabbit.yaml`, `.github/copilot-instructions.md`.

**Docs**
- README rewritten for SPM install, API, concurrency, requirements, and project health.
- `CHANGELOG.md`, `CONTRIBUTING.md`, `SECURITY.md`, `CODE_OF_CONDUCT.md`, `docs/MAINTAINING.md` (GitHub settings checklist).

## Breaking changes

- Minimum platform is iOS 17 and Swift 6 (was iOS 16 and Swift 5).
- `changeDate(_:)` and `UIImage.toBase64String` return optionals.
- `ExFunction` is an `enum` namespace.
- `dismissKeyboardOnTap()` is unavailable in app extensions.

See `CHANGELOG.md` for the full list.

## Verification

Run locally before this PR:

- `xcrun swift-format lint --strict --recursive Sources Tests`: clean
- `swift build -Xswiftc -warnings-as-errors` and `swift test`: 21 tests passing (macOS host)
- `xcodebuild test -scheme SwiftExtension` on an iPhone simulator: 35 tests passing, 87% library coverage, warnings as errors
- `xcodebuild test` on the example app: 3 tests passing, no warnings
- `xcodebuild docbuild`: succeeds

Not yet verified on GitHub-hosted runners. The workflows have not run on GitHub.

## Reviewer notes

- The `xcuserdata/` scheme file was removed from tracking and is now ignored.
- Review bots need manual setup on GitHub (CodeRabbit app, Copilot ruleset). See `docs/MAINTAINING.md`.
- Please check that the Danger workflow's fork-PR guard matches how you want external PRs handled.

🤖 Generated with [Claude Code](https://claude.com/claude-code)
