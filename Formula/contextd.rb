# frozen_string_literal: true

class Contextd < Formula
  desc "Portable, vendor-neutral context for AI"
  homepage "https://github.com/abyssmemes/contextverse"
  version "0.20.0"
  license "BUSL-1.1"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    on_arm do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.20.0/contextd_0.20.0_darwin_arm64.tar.gz"
      sha256 "1559ff513294cf23e8bcc4998ede86a22e8cb14fff8b1d7829b116c5b542217e"
    end
    on_intel do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.20.0/contextd_0.20.0_darwin_amd64.tar.gz"
      sha256 "0132814cded45c2e2e388583bb1221b5318c1ff8306264799fa52c6d3624148d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.20.0/contextd_0.20.0_linux_arm64.tar.gz"
      sha256 "a50d7451ee2c4e55c43730383443b9fef9ff338e26b85e40c1d3c9a21eeb6013"
    end
    on_intel do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.20.0/contextd_0.20.0_linux_amd64.tar.gz"
      sha256 "66dfa520e55e70776529d95be847424caed4cb9d56cbc78bd755c277a3c91ad3"
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
