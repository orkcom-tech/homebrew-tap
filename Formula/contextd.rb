# frozen_string_literal: true

class Contextd < Formula
  desc "Portable, vendor-neutral context for AI"
  homepage "https://github.com/abyssmemes/contextverse"
  version "0.18.0"
  license "BUSL-1.1"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    on_arm do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.18.0/contextd_0.18.0_darwin_arm64.tar.gz"
      sha256 "96420e74a9ef477aca8a198f39c6a07cdfe232b2f831876f2f3fa1e813167715"
    end
    on_intel do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.18.0/contextd_0.18.0_darwin_amd64.tar.gz"
      sha256 "d023d251a6c208ab2d7af36bb738e8a7e58d8098beec1d1f3de1fbc42db9d5c1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.18.0/contextd_0.18.0_linux_arm64.tar.gz"
      sha256 "dc9621f7d50eaf2d3af8f951065ae5d2a024e9d72af41f2f27a0645912aa5eb0"
    end
    on_intel do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.18.0/contextd_0.18.0_linux_amd64.tar.gz"
      sha256 "dce3dc15bd73133a04a938c028ba0f3b49cd03c8b55922389e514c59a1aa4414"
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
