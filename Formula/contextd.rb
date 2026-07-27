# frozen_string_literal: true

class Contextd < Formula
  desc "Portable, vendor-neutral context for AI"
  homepage "https://github.com/abyssmemes/contextverse"
  version "0.12.0"
  license "BUSL-1.1"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    on_arm do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.12.0/contextd_0.12.0_darwin_arm64.tar.gz"
      sha256 "9479a68e7189d82925e52f2d4f033bb29ec6d02428b8e0be4d64257e28735fb3"
    end
    on_intel do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.12.0/contextd_0.12.0_darwin_amd64.tar.gz"
      sha256 "5b44d050c3852602606641ac0bd97b349dd81382a24546cae2efb2cac50b4303"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.12.0/contextd_0.12.0_linux_arm64.tar.gz"
      sha256 "37a92c092b193b79aec12910e49bf305b3d5afc6b63a433ee3e20ccd799488c0"
    end
    on_intel do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.12.0/contextd_0.12.0_linux_amd64.tar.gz"
      sha256 "1ad850fa71c3e21a8be89bfb095f092fa9b1802fd665094899b2e05320fed52d"
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
