# frozen_string_literal: true

class Contextd < Formula
  desc "Portable, vendor-neutral context for AI"
  homepage "https://github.com/orkcom-tech/contextverse"
  version "0.28.0"
  license "BUSL-1.1"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    on_arm do
      url "https://github.com/orkcom-tech/contextverse/releases/download/v0.28.0/contextd_0.28.0_darwin_arm64.tar.gz"
      sha256 "7d1bdff031824c3a9acbf0e104fc95c4f258810623fc9a92fcf6d8f818faba88"
    end
    on_intel do
      url "https://github.com/orkcom-tech/contextverse/releases/download/v0.28.0/contextd_0.28.0_darwin_amd64.tar.gz"
      sha256 "c488b19db92177f7839657acf1e13c71f0d3df2f92805889f39e1b3d5adcdc90"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/orkcom-tech/contextverse/releases/download/v0.28.0/contextd_0.28.0_linux_arm64.tar.gz"
      sha256 "b2292c832be8fdc14afbbc748a5b77f073874d4399dc1c254622ca72d7384998"
    end
    on_intel do
      url "https://github.com/orkcom-tech/contextverse/releases/download/v0.28.0/contextd_0.28.0_linux_amd64.tar.gz"
      sha256 "99eab7b59d55833354fb6926df53c92726757a760b95c0d2b4a237ac16e65e1c"
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
