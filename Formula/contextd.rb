# frozen_string_literal: true

class Contextd < Formula
  desc "Portable, vendor-neutral context for AI"
  homepage "https://github.com/abyssmemes/contextverse"
  version "0.11.0"
  license "BUSL-1.1"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    on_arm do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.11.0/contextd_0.11.0_darwin_arm64.tar.gz"
      sha256 "4f3dc72614483c87fc67919c31a7f7e01edc39b4ca14bbdc454f6ff40dc58021"
    end
    on_intel do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.11.0/contextd_0.11.0_darwin_amd64.tar.gz"
      sha256 "34ba5e6c6a1a48f3a309ebae3ca2b6a872d8859eec7901183b6a7cd153a40163"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.11.0/contextd_0.11.0_linux_arm64.tar.gz"
      sha256 "5edbe9a567ea428aec33ef56a63c30211be9d21467a786dcd9589c1ede2e167b"
    end
    on_intel do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.11.0/contextd_0.11.0_linux_amd64.tar.gz"
      sha256 "a41723a004377503fde08f0df491120c4540e5e4a69a7da6a47c17277d04595a"
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
