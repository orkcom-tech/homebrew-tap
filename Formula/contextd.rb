# frozen_string_literal: true

class Contextd < Formula
  desc "Portable, vendor-neutral context for AI"
  homepage "https://github.com/orkcom-tech/contextverse"
  version "0.30.0"
  license "BUSL-1.1"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    on_arm do
      url "https://github.com/orkcom-tech/contextverse/releases/download/v0.30.0/contextd_0.30.0_darwin_arm64.tar.gz"
      sha256 "29afd9e9263c98138456d474bfd605af7bff34868c9d37970d70fbd1946054f0"
    end
    on_intel do
      url "https://github.com/orkcom-tech/contextverse/releases/download/v0.30.0/contextd_0.30.0_darwin_amd64.tar.gz"
      sha256 "3a9ac9943c4fbd016dd5f610b33f93dd61bac0835cde4c0759e8ba9169380f10"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/orkcom-tech/contextverse/releases/download/v0.30.0/contextd_0.30.0_linux_arm64.tar.gz"
      sha256 "ae12824bf2c01a3821a12955e84b8ba1d4b6bd9bf2dcb59fce7379bd2cd279a3"
    end
    on_intel do
      url "https://github.com/orkcom-tech/contextverse/releases/download/v0.30.0/contextd_0.30.0_linux_amd64.tar.gz"
      sha256 "56bbb439c3dc3b5da3c82a5fa5e2b1a895b552c7ed3f2d6d6391f28c82973a66"
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
