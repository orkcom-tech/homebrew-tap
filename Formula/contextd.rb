# frozen_string_literal: true

class Contextd < Formula
  desc "Portable, vendor-neutral context for AI"
  homepage "https://github.com/orkcom-tech/contextverse"
  version "1.0.0"
  license "BUSL-1.1"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    on_arm do
      url "https://github.com/orkcom-tech/contextverse/releases/download/v1.0.0/contextd_1.0.0_darwin_arm64.tar.gz"
      sha256 "4b76b3fb824b251210ad7f764410ab069d2da17c16e97f34c4d1f62910d27921"
    end
    on_intel do
      url "https://github.com/orkcom-tech/contextverse/releases/download/v1.0.0/contextd_1.0.0_darwin_amd64.tar.gz"
      sha256 "a3307a63d7891821d8d463ee9d393c6981e1ab0a367fde03c155d1840dee8dc8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/orkcom-tech/contextverse/releases/download/v1.0.0/contextd_1.0.0_linux_arm64.tar.gz"
      sha256 "5629f3cf9b4d6a4f1ecffbb47fddef611cfbf0abb28422fc04f6d18e021ceaf8"
    end
    on_intel do
      url "https://github.com/orkcom-tech/contextverse/releases/download/v1.0.0/contextd_1.0.0_linux_amd64.tar.gz"
      sha256 "d1d6fdc80e54e3fcefe5ce6cd6809cae5fa8dd5fb3d3b76578d40016b09e5b4f"
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
