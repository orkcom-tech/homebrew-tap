# frozen_string_literal: true

class Contextd < Formula
  desc "Portable, vendor-neutral context for AI"
  homepage "https://github.com/orkcom-tech/contextverse"
  version "0.31.0"
  license "BUSL-1.1"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    on_arm do
      url "https://github.com/orkcom-tech/contextverse/releases/download/v0.31.0/contextd_0.31.0_darwin_arm64.tar.gz"
      sha256 "ffdad69105a63661ce1fa6119e866d5a1dc7fdb95130a13a59538005ae737699"
    end
    on_intel do
      url "https://github.com/orkcom-tech/contextverse/releases/download/v0.31.0/contextd_0.31.0_darwin_amd64.tar.gz"
      sha256 "872b5268859d64da14d412c9156f122000a8f845347e3fba891baaa1e229f043"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/orkcom-tech/contextverse/releases/download/v0.31.0/contextd_0.31.0_linux_arm64.tar.gz"
      sha256 "bcb4a225b0b59710968ad458b4c65ab3627e467167735f62989e84d5b0beeb8a"
    end
    on_intel do
      url "https://github.com/orkcom-tech/contextverse/releases/download/v0.31.0/contextd_0.31.0_linux_amd64.tar.gz"
      sha256 "e696a8a5ca522a0fdffb04c27bbc411fb399025cb5060146411a4addaa154fb5"
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
