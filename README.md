# Homebrew Tap for ContextVerse

Own Homebrew tap — not submitted to `homebrew-core`.

```bash
brew tap orkcom-tech/tap
brew install orkcom-tech/tap/contextd
```

When a GitHub organization exists, this repo can move there and the tap name can change (e.g. `contextverse/tap`).

## Updating the formula after a release

1. Publish a `v*` tag on [`contextverse`](https://github.com/orkcom-tech/contextverse) (GoReleaser builds assets + `checksums.txt`).
2. Refresh `Formula/contextd.rb` version, URLs, and SHA256s (`./scripts/bump-formula.sh vX.Y.Z`).
3. Commit and push.

## License

Formula files: Apache-2.0. The `contextd` binary itself remains BUSL-1.1 — see the main repo.
