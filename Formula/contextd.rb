# frozen_string_literal: true

class Contextd < Formula
  desc "Portable, vendor-neutral context for AI"
  homepage "https://github.com/abyssmemes/contextverse"
  version "0.14.0"
  license "BUSL-1.1"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    on_arm do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.14.0/contextd_0.14.0_darwin_arm64.tar.gz"
      sha256 "82803c8fbfc14fde7b52a8907fe4174fd8a6791fb2de1ed78b47be350e4ce85b"
    end
    on_intel do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.14.0/contextd_0.14.0_darwin_amd64.tar.gz"
      sha256 "0f928961deca0eec87bf695145a4a4a7f349dfab9b0f2044e0f1b83a5a592636"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.14.0/contextd_0.14.0_linux_arm64.tar.gz"
      sha256 "5f0870b4b60bb49a94614e5ed04f351cec81b35213e0e0b99ce2a5d811d3f1a2"
    end
    on_intel do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.14.0/contextd_0.14.0_linux_amd64.tar.gz"
      sha256 "56003af5c6a883b31526bc2331d7ae888dc3d51eafc68be9dbd5c9f124fc9533"
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
