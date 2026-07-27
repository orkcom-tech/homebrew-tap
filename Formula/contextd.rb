# frozen_string_literal: true

class Contextd < Formula
  desc "Portable, vendor-neutral context for AI"
  homepage "https://github.com/abyssmemes/contextverse"
  version "0.16.0"
  license "BUSL-1.1"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    on_arm do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.16.0/contextd_0.16.0_darwin_arm64.tar.gz"
      sha256 "bf332962c8d82bebf56f36e5ef09f5afb8a3971bf11f41af8be0e0c815f65df6"
    end
    on_intel do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.16.0/contextd_0.16.0_darwin_amd64.tar.gz"
      sha256 "adf5c34b3541711de15755ca3391845e661fd37a790a2f0913cbbb9b1d4836f9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.16.0/contextd_0.16.0_linux_arm64.tar.gz"
      sha256 "d23cf083b705b23427e90f6391b1f1d4f17c20d5c2ea57958bfee8bdd98baee5"
    end
    on_intel do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.16.0/contextd_0.16.0_linux_amd64.tar.gz"
      sha256 "a7934ada75e7a4ff61f3aba7a1d02edf02a7fc14a20645e2823cd748e0d071f5"
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
