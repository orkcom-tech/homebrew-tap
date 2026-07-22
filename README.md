# Homebrew Tap for ContextVerse

Private Homebrew tap (HashiCorp-style) — **not** submitted to `homebrew-core`.

```bash
brew tap abyssmemes/tap
brew install abyssmemes/tap/contextd
```

Later, when the GitHub org exists: transfer this repo and retap as `contextverse/tap` (or keep `abyssmemes/tap`).

## Updating the formula after a release

1. Publish a `v*` tag on [`contextverse`](https://github.com/abyssmemes/contextverse) (GoReleaser builds assets + `checksums.txt`).
2. Refresh `Formula/contextd.rb` version, URLs, and SHA256s (see `scripts/bump-formula.sh` in this repo).
3. Commit and push.

## License

Formula files: Apache-2.0. The `contextd` binary itself remains BUSL-1.1 — see the main repo.
