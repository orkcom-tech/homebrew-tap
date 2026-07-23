# frozen_string_literal: true

class Contextd < Formula
  desc "Portable, vendor-neutral context for AI"
  homepage "https://github.com/abyssmemes/contextverse"
  version "0.3.0"
  license "BUSL-1.1"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    on_arm do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.3.0/contextd_0.3.0_darwin_arm64.tar.gz"
      sha256 "8dea5aca4db19872a7e961725a3631482cab586d1891533d5d129766c5ad4948"
    end
    on_intel do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.3.0/contextd_0.3.0_darwin_amd64.tar.gz"
      sha256 "8a5567c9fe53e2892a2703cd7f1c592c877b7cc37f5d275ab164aadef03c5906"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.3.0/contextd_0.3.0_linux_arm64.tar.gz"
      sha256 "ac92333cff5476041f7d35423895942b75e7c9e84a5c02d9d81a1711cb95732f"
    end
    on_intel do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.3.0/contextd_0.3.0_linux_amd64.tar.gz"
      sha256 "57286493ebda08c312cdaac6ca48a1e4cc21cd1cf1df16c70e052300e9592ece"
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
