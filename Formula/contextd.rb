# frozen_string_literal: true

class Contextd < Formula
  desc "Portable, vendor-neutral context for AI"
  homepage "https://github.com/abyssmemes/contextverse"
  version "0.13.0"
  license "BUSL-1.1"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    on_arm do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.13.0/contextd_0.13.0_darwin_arm64.tar.gz"
      sha256 "beeace15caea7498f69cc6e0e24991e6a77e635263d0084141d7995e9806798b"
    end
    on_intel do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.13.0/contextd_0.13.0_darwin_amd64.tar.gz"
      sha256 "977e3610f7f69e959099946bda5faca4c4d3a358f17f80f3ce78cf8e719ea80e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.13.0/contextd_0.13.0_linux_arm64.tar.gz"
      sha256 "4219033a223a093c2c75e52b5b652417388499d05d0fd799f0700ea4835cdf11"
    end
    on_intel do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.13.0/contextd_0.13.0_linux_amd64.tar.gz"
      sha256 "8d6c93b4088894320b6cb7a3aea592719817ae5994ac9301b81237c0943bb06b"
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

      Quick start:
        contextd init solo
        cd <project> && contextd activate
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/contextd version")
  end
end
