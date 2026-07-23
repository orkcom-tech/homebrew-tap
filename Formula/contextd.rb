# frozen_string_literal: true

class Contextd < Formula
  desc "Portable, vendor-neutral context for AI"
  homepage "https://github.com/abyssmemes/contextverse"
  version "0.4.0"
  license "BUSL-1.1"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    on_arm do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.4.0/contextd_0.4.0_darwin_arm64.tar.gz"
      sha256 "4defc51f69d743c67798340c16ad0d8d6e362935bb1fbfd814675cadf8bb5c34"
    end
    on_intel do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.4.0/contextd_0.4.0_darwin_amd64.tar.gz"
      sha256 "5b7f9d41b865cf7645aaa7442189c8844c43357c19a638137e040cc6d21c60d5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.4.0/contextd_0.4.0_linux_arm64.tar.gz"
      sha256 "c17c31042251d10e654a14b6cc30c7db0bc6f71bc84a8eec500b77d95bceab76"
    end
    on_intel do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.4.0/contextd_0.4.0_linux_amd64.tar.gz"
      sha256 "b6a4a3c1f29a4f8b1b6c795dffa8a76fab888b551c60b358697e0eb25a1f004e"
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
