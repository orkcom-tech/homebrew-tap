# frozen_string_literal: true

class Contextd < Formula
  desc "Portable, vendor-neutral context for AI"
  homepage "https://github.com/abyssmemes/contextverse"
  version "0.15.0"
  license "BUSL-1.1"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    on_arm do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.15.0/contextd_0.15.0_darwin_arm64.tar.gz"
      sha256 "717ed795516dc45a4a51fbf56d1028d94b07553f9af6c2b6d3c93b76620e1a05"
    end
    on_intel do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.15.0/contextd_0.15.0_darwin_amd64.tar.gz"
      sha256 "557cc34bd77dc8d34e6648e137f9a9a9e966f6c3c7840a44b1ade7254a73cc7a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.15.0/contextd_0.15.0_linux_arm64.tar.gz"
      sha256 "cf005828dcc7a240565c32d5f803e07c48829c25f2de819294c87da8a7e4079f"
    end
    on_intel do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.15.0/contextd_0.15.0_linux_amd64.tar.gz"
      sha256 "42c2719a70bace205799866a7062031acb93dc7c23f694a101937baa317d995f"
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
