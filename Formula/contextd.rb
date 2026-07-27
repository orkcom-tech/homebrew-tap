# frozen_string_literal: true

class Contextd < Formula
  desc "Portable, vendor-neutral context for AI"
  homepage "https://github.com/abyssmemes/contextverse"
  version "0.17.0"
  license "BUSL-1.1"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    on_arm do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.17.0/contextd_0.17.0_darwin_arm64.tar.gz"
      sha256 "d692db727198c825b8f63477f41096214cd6cdeb2b496d2bf18c9b2c09e5c3ca"
    end
    on_intel do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.17.0/contextd_0.17.0_darwin_amd64.tar.gz"
      sha256 "d04cee86d8ce79ff4cfddc8fc397829b7c1f880ae3560539776b9d4fcabb3d71"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.17.0/contextd_0.17.0_linux_arm64.tar.gz"
      sha256 "4451c40f40ac17cf8f622ad721080e5c061f97fccd8fdbebbaef65cf6e3b469b"
    end
    on_intel do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.17.0/contextd_0.17.0_linux_amd64.tar.gz"
      sha256 "00a08ee9e9b3dbef34680778efc4fb2af6660f431da3c9088e6b84611487b132"
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
