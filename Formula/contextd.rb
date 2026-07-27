# frozen_string_literal: true

class Contextd < Formula
  desc "Portable, vendor-neutral context for AI"
  homepage "https://github.com/abyssmemes/contextverse"
  version "0.7.0"
  license "BUSL-1.1"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    on_arm do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.7.0/contextd_0.7.0_darwin_arm64.tar.gz"
      sha256 "2b5976b905fb6bab962cd5d0e701b1894a43c74936aaa35313907d829b043812"
    end
    on_intel do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.7.0/contextd_0.7.0_darwin_amd64.tar.gz"
      sha256 "89b001cffef0f8ef95f5756de1e96d8534985c3f9b54245143a636e0658ed87e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.7.0/contextd_0.7.0_linux_arm64.tar.gz"
      sha256 "eb28ec2db2d586214ff4a0a9796fc58a3384efca1672362f24b6415f4893b0d3"
    end
    on_intel do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.7.0/contextd_0.7.0_linux_amd64.tar.gz"
      sha256 "e5f27b88ea90f988a614bcfc6938c6a274bfdd53e61cc5487b51ff63c1cfff03"
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
