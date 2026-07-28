# frozen_string_literal: true

class Contextd < Formula
  desc "Portable, vendor-neutral context for AI"
  homepage "https://github.com/abyssmemes/contextverse"
  version "0.21.0"
  license "BUSL-1.1"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    on_arm do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.21.0/contextd_0.21.0_darwin_arm64.tar.gz"
      sha256 "2c8bc24a8650c988ddc50dcf1a38ecdb1a3cb26d52c6a537d81ecec944e2c6c3"
    end
    on_intel do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.21.0/contextd_0.21.0_darwin_amd64.tar.gz"
      sha256 "73cab949f5856710ba828221554b620b73c2150328acb032da82548e6ecfcab5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.21.0/contextd_0.21.0_linux_arm64.tar.gz"
      sha256 "58d2c7b54d6848021f3620d3dc182cab72de0a97679ece3d220996a70d2a3371"
    end
    on_intel do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.21.0/contextd_0.21.0_linux_amd64.tar.gz"
      sha256 "b2b21815ac4069a13ed6e51c8dc22edf4ff5a81331a519e7b2edd210ba52667d"
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
