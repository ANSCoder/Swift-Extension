# Maintaining

Settings that live in GitHub's UI and cannot be committed. Do these once.

## Repository settings

- [ ] **Branch protection** (or a ruleset) on `main`: require a pull request, require the status check **CI success**, require conversation resolution, block force pushes.
- [ ] **Dependabot alerts and security updates**: Settings → Code security.
- [ ] **Private vulnerability reporting**: Settings → Code security.
- [ ] **Code scanning**: CodeQL results appear after the first workflow run.
- [ ] **Discussions**: enable, since the issue template points to them.
- [ ] **Topics**: `swift`, `swift-package-manager`, `swiftui`, `uikit`, `ios`, `extensions`.

## Review bots

- [ ] **GitHub Copilot code review**: Settings → Rules → Rulesets → add rule "Automatically request Copilot code review". It reads `.github/copilot-instructions.md`.
- [ ] **CodeRabbit**: install the CodeRabbit GitHub app for this repository. It reads `.coderabbit.yaml`.
- [ ] **Danger**: no setup. It runs from `.github/workflows/danger.yml` with the default `GITHUB_TOKEN`. It cannot comment on fork PRs.

## Labels

Create these once so labeling and release notes work: `feature`, `enhancement`, `bug`, `fix`, `breaking`, `documentation`, `tests`, `ci`, `dependencies`, `chore`, `library`, `example-app`, `stale`, `pinned`.

## Releasing

1. Move **Unreleased** in `CHANGELOG.md` under the new version and date.
2. Merge to `main` and wait for **CI success**.
3. Tag and push: `git tag 1.0.0 && git push origin 1.0.0`.
4. The **Release** workflow builds, tests and publishes a GitHub release with generated notes.
5. SwiftPM resolves the tag. No registry step is needed.

## Swift Package Index

1. Open https://swiftpackageindex.com/add-a-package and submit `https://github.com/ANSCoder/Swift-Extension.git`.
2. `.spi.yml` already builds the DocC documentation for the `SwiftExtension` scheme on iOS.
3. The README badges for Swift versions and platforms start working once the package is listed.

## Pinning actions

Workflows use major version tags. For stricter supply-chain hygiene, pin third-party actions to commit SHAs and let Dependabot update them.
