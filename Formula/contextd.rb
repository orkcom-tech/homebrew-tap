# frozen_string_literal: true

class Contextd < Formula
  desc "Portable, vendor-neutral context for AI"
  homepage "https://github.com/abyssmemes/contextverse"
  version "0.19.0"
  license "BUSL-1.1"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    on_arm do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.19.0/contextd_0.19.0_darwin_arm64.tar.gz"
      sha256 "db384e4c6cf41abf23b1dcf81aecf60f8f70b98c06ee80c805eab5105e3d954e"
    end
    on_intel do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.19.0/contextd_0.19.0_darwin_amd64.tar.gz"
      sha256 "ef484be4ec44b38412a3facb85ee87d45ae22ec3fd59ccaa197a244c1d034704"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.19.0/contextd_0.19.0_linux_arm64.tar.gz"
      sha256 "00a7182ea5562c5e3c9b190551ee3e3be0dabd257c0e51a6c6cb357fa5bcb5bd"
    end
    on_intel do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.19.0/contextd_0.19.0_linux_amd64.tar.gz"
      sha256 "1fbcfbac995f7d6d98e292f456d2b5486fc20b61fb12f5a3c29c375525b4d8bd"
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
