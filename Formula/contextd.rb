# frozen_string_literal: true

class Contextd < Formula
  desc "Portable, vendor-neutral context for AI"
  homepage "https://github.com/orkcom-tech/contextverse"
  version "0.29.0"
  license "BUSL-1.1"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    on_arm do
      url "https://github.com/orkcom-tech/contextverse/releases/download/v0.29.0/contextd_0.29.0_darwin_arm64.tar.gz"
      sha256 "d0c149bca587a878e70d1c4659e6c9f97826bec22463d0bf59ca222dfd6ff4e7"
    end
    on_intel do
      url "https://github.com/orkcom-tech/contextverse/releases/download/v0.29.0/contextd_0.29.0_darwin_amd64.tar.gz"
      sha256 "754e3738ee45a0770a4ad1bd33c0dfa9cf790cea6c54947f8f3104e042480080"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/orkcom-tech/contextverse/releases/download/v0.29.0/contextd_0.29.0_linux_arm64.tar.gz"
      sha256 "187cd106abcb294dbe50709799ada327b4302e3b30da5cd6fcc8f1f4bc4978cf"
    end
    on_intel do
      url "https://github.com/orkcom-tech/contextverse/releases/download/v0.29.0/contextd_0.29.0_linux_amd64.tar.gz"
      sha256 "f4c5a0c892e96ab9f7ad388896033ca5cc7c34bf6c83395796e17850fa26d212"
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
