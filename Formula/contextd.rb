# frozen_string_literal: true

class Contextd < Formula
  desc "Portable, vendor-neutral context for AI"
  homepage "https://github.com/abyssmemes/contextverse"
  version "0.10.0"
  license "BUSL-1.1"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    on_arm do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.10.0/contextd_0.10.0_darwin_arm64.tar.gz"
      sha256 "56dd27681f1da8a66ba5aef2fcbf0df51ba33edae82b87ecb097462a4fc65c83"
    end
    on_intel do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.10.0/contextd_0.10.0_darwin_amd64.tar.gz"
      sha256 "45a5515758d5748e5f2b41cbd0c0e9d19e6c1a13ee48b9244bcdaee93e4723e4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.10.0/contextd_0.10.0_linux_arm64.tar.gz"
      sha256 "7d44a987a6fc29b87437701007d3fb6bdd3339e97eee637ba5b10eea7aa6c51b"
    end
    on_intel do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.10.0/contextd_0.10.0_linux_amd64.tar.gz"
      sha256 "43c7bfd6f1b3c83cdb315f24f1e35aba37077a5ab8c6c59dd081344320af2747"
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
