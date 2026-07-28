# frozen_string_literal: true

class Contextd < Formula
  desc "Portable, vendor-neutral context for AI"
  homepage "https://github.com/orkcom-tech/contextverse"
  version "0.27.0"
  license "BUSL-1.1"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    on_arm do
      url "https://github.com/orkcom-tech/contextverse/releases/download/v0.27.0/contextd_0.27.0_darwin_arm64.tar.gz"
      sha256 "6405f0e415d87e913426343813393b0fb190ce65bae0919105a93623ff66ad4e"
    end
    on_intel do
      url "https://github.com/orkcom-tech/contextverse/releases/download/v0.27.0/contextd_0.27.0_darwin_amd64.tar.gz"
      sha256 "f71a53d9a64b01b2b966c52c5449b3e0a22b466618dc90c85a84df65fbdee3ff"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/orkcom-tech/contextverse/releases/download/v0.27.0/contextd_0.27.0_linux_arm64.tar.gz"
      sha256 "fadc89e9e8897171c40db7d9675fa0f636eeae427de050c6413a100f974b86bc"
    end
    on_intel do
      url "https://github.com/orkcom-tech/contextverse/releases/download/v0.27.0/contextd_0.27.0_linux_amd64.tar.gz"
      sha256 "0e28b0111b7d8cf98b9846d31466ade6168ba139eb057d07455344099b7e8d45"
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
