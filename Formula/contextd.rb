# frozen_string_literal: true

require_relative "../Lib/private_strategy"

class Contextd < Formula
  desc "Portable, vendor-neutral context for AI"
  homepage "https://github.com/abyssmemes/contextverse"
  version "0.0.1"
  license "BUSL-1.1"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    on_arm do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.0.1/contextd_0.0.1_darwin_arm64.tar.gz",
          using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "8af569b843250c64118a58d9a5d4a7e7fe90248ad4e0e1f463aa941dc774d913"
    end
    on_intel do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.0.1/contextd_0.0.1_darwin_amd64.tar.gz",
          using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "38acd221354d5418813b40cd3f8d5741adfa6639968a71e026a1c48cc19e1c55"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.0.1/contextd_0.0.1_linux_arm64.tar.gz",
          using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "18231468462e87900c59add0618c22f67c795274d82a7e830023222eab9efe69"
    end
    on_intel do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.0.1/contextd_0.0.1_linux_amd64.tar.gz",
          using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "a52b6d9aaed2543aebed392719c69ed54fff2995a63248452ec59f704f921337"
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

        export HOMEBREW_GITHUB_API_TOKEN="$(gh auth token)"

      Quick start:
        contextd init solo
        cd <project> && contextd activate
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/contextd version")
  end
end
