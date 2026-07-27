# frozen_string_literal: true

class Contextd < Formula
  desc "Portable, vendor-neutral context for AI"
  homepage "https://github.com/abyssmemes/contextverse"
  version "0.8.0"
  license "BUSL-1.1"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    on_arm do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.8.0/contextd_0.8.0_darwin_arm64.tar.gz"
      sha256 "a397520d1898ffea21f48a2589029cb9a84a7506a35d99c241db1bde9ea8b876"
    end
    on_intel do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.8.0/contextd_0.8.0_darwin_amd64.tar.gz"
      sha256 "5f4b0d63beac32d51039162f495548049b4c5c9e32a7c50b512e26d5590ef0c9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.8.0/contextd_0.8.0_linux_arm64.tar.gz"
      sha256 "3328043ee6f9d39df0d41e57f774c3ad44d7dca81f926b5a57d7c71654a68089"
    end
    on_intel do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.8.0/contextd_0.8.0_linux_amd64.tar.gz"
      sha256 "d50c7843bf47447d6a77eaab66d8c7927d5b7a29df9d3627980de1d6e2b4a488"
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
