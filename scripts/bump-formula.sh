#!/usr/bin/env bash
# Refresh Formula/contextd.rb from a contextverse GitHub release.
#
# Usage:
#   ./scripts/bump-formula.sh v0.0.2
#   CONTEXTVERSE_REPO=abyssmemes/contextverse ./scripts/bump-formula.sh v0.0.2
set -euo pipefail

TAG="${1:-}"
[[ -n "$TAG" ]] || { echo "usage: $0 <tag>  (e.g. v0.0.2)" >&2; exit 1; }
REPO="${CONTEXTVERSE_REPO:-abyssmemes/contextverse}"
VER="${TAG#v}"
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
FORMULA="${ROOT}/Formula/contextd.rb"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

echo "==> Fetching checksums for ${TAG} from ${REPO}"
gh release download "$TAG" --repo "$REPO" --pattern checksums.txt --dir "$TMP"
SUMS="${TMP}/checksums.txt"

sha() {
  local file="$1"
  awk -v f="$file" '$2 == f { print $1; exit }' "$SUMS"
}

DARWIN_ARM64="$(sha "contextd_${VER}_darwin_arm64.tar.gz")"
DARWIN_AMD64="$(sha "contextd_${VER}_darwin_amd64.tar.gz")"
LINUX_ARM64="$(sha "contextd_${VER}_linux_arm64.tar.gz")"
LINUX_AMD64="$(sha "contextd_${VER}_linux_amd64.tar.gz")"

for v in DARWIN_ARM64 DARWIN_AMD64 LINUX_ARM64 LINUX_AMD64; do
  [[ -n "${!v}" ]] || { echo "missing checksum for $v" >&2; exit 1; }
done

BASE="https://github.com/${REPO}/releases/download/${TAG}"

cat >"$FORMULA" <<EOF
# frozen_string_literal: true

require_relative "../Lib/private_strategy"

class Contextd < Formula
  desc "Portable, vendor-neutral context for AI"
  homepage "https://github.com/${REPO}"
  version "${VER}"
  license "BUSL-1.1"

  livecheck do
    url :stable
    regex(/^v?(\\d+(?:\\.\\d+)+)\$/i)
  end

  on_macos do
    on_arm do
      url "${BASE}/contextd_${VER}_darwin_arm64.tar.gz",
          using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "${DARWIN_ARM64}"
    end
    on_intel do
      url "${BASE}/contextd_${VER}_darwin_amd64.tar.gz",
          using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "${DARWIN_AMD64}"
    end
  end

  on_linux do
    on_arm do
      url "${BASE}/contextd_${VER}_linux_arm64.tar.gz",
          using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "${LINUX_ARM64}"
    end
    on_intel do
      url "${BASE}/contextd_${VER}_linux_amd64.tar.gz",
          using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "${LINUX_AMD64}"
    end
  end

  def install
    bin.install "contextd"
  end

  def caveats
    <<~EOS
      contextd is licensed under BUSL-1.1 (source-available).
      You may self-host and use it in production; you may not offer it as a
      competing hosted service. Each version converts to Apache-2.0 after 4 years.

      While the GitHub repos are private, Homebrew needs a token to download
      release assets:

        export HOMEBREW_GITHUB_API_TOKEN="\$(gh auth token)"

      Quick start:
        contextd init solo
        cd <project> && contextd activate
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/contextd version")
  end
end
EOF

echo "==> Wrote ${FORMULA} for ${TAG}"
echo "    Note: when the release repo becomes public, drop 'using: GitHubPrivateRepositoryReleaseDownloadStrategy'."
