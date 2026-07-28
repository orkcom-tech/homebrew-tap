# frozen_string_literal: true

class Contextd < Formula
  desc "Portable, vendor-neutral context for AI"
  homepage "https://github.com/orkcom-tech/contextverse"
  version "0.26.0"
  license "BUSL-1.1"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    on_arm do
      url "https://github.com/orkcom-tech/contextverse/releases/download/v0.26.0/contextd_0.26.0_darwin_arm64.tar.gz"
      sha256 "a8d35896e3631f0c049cdf0f0f3a1950fe0a98e8cf00526dd4427d6286d0380b"
    end
    on_intel do
      url "https://github.com/orkcom-tech/contextverse/releases/download/v0.26.0/contextd_0.26.0_darwin_amd64.tar.gz"
      sha256 "76795159eb6e2b19ca3a0bcb64b9be829cd71dab1c46138e3410cd43f2575b35"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/orkcom-tech/contextverse/releases/download/v0.26.0/contextd_0.26.0_linux_arm64.tar.gz"
      sha256 "755822de97d19a24eb587f56e7209361561e64890981761b60b6c21b8c8a33c9"
    end
    on_intel do
      url "https://github.com/orkcom-tech/contextverse/releases/download/v0.26.0/contextd_0.26.0_linux_amd64.tar.gz"
      sha256 "46769557177acbdfb43294d21dba670c75ba2bb3e4ba1b1b215c4efb20d75f6b"
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
