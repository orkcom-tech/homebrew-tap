# frozen_string_literal: true

class Contextd < Formula
  desc "Portable, vendor-neutral context for AI"
  homepage "https://github.com/abyssmemes/contextverse"
  version "0.5.0"
  license "BUSL-1.1"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    on_arm do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.5.0/contextd_0.5.0_darwin_arm64.tar.gz"
      sha256 "59ac9c9d19e5bb43f57e5bca668e555f7abc0b29af90ba1b3d17c73fa38a5f24"
    end
    on_intel do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.5.0/contextd_0.5.0_darwin_amd64.tar.gz"
      sha256 "4a46d01e10301de7c7471ddd97ce085f9035fde9b55927d7b50add3261d7faa3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.5.0/contextd_0.5.0_linux_arm64.tar.gz"
      sha256 "96363ed30b229e9c4a4266bd5be5a57a839bc9936d6c99f06f63c5ba24e88d60"
    end
    on_intel do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.5.0/contextd_0.5.0_linux_amd64.tar.gz"
      sha256 "0127485ee0d5b8a092351770fef64b6cade22281ebc9a0c6990de71fb5330dfb"
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
