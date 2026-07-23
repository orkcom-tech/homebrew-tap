# frozen_string_literal: true

class Contextd < Formula
  desc "Portable, vendor-neutral context for AI"
  homepage "https://github.com/abyssmemes/contextverse"
  version "0.6.0"
  license "BUSL-1.1"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    on_arm do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.6.0/contextd_0.6.0_darwin_arm64.tar.gz"
      sha256 "3fc0b397ea543d53403dbd6c7de895c9eb1b3b1c2f5665b4dfb47520374ca6ca"
    end
    on_intel do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.6.0/contextd_0.6.0_darwin_amd64.tar.gz"
      sha256 "e885f9d28d19636940fb0efc3ed62dc853cc5dc8512647f01938e1272c525a58"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.6.0/contextd_0.6.0_linux_arm64.tar.gz"
      sha256 "622878505a4468ee56c306ea09eb607e698fde6fbde87a2e6c1a7f205c88d714"
    end
    on_intel do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.6.0/contextd_0.6.0_linux_amd64.tar.gz"
      sha256 "45d6270c9833be96282a4f104514925f934fa2a788902fdbd4b58935e2ebf1f6"
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
