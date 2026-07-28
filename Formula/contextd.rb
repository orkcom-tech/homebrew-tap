# frozen_string_literal: true

class Contextd < Formula
  desc "Portable, vendor-neutral context for AI"
  homepage "https://github.com/abyssmemes/contextverse"
  version "0.22.0"
  license "BUSL-1.1"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    on_arm do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.22.0/contextd_0.22.0_darwin_arm64.tar.gz"
      sha256 "225a558ade5d210410b91024c907e373816777472a180dda23c6a6b8b5b96fb4"
    end
    on_intel do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.22.0/contextd_0.22.0_darwin_amd64.tar.gz"
      sha256 "3c820d7c0995aa1d408840e6fd2426a97806f5a5511ac401750d8db328fc13a7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.22.0/contextd_0.22.0_linux_arm64.tar.gz"
      sha256 "b9be6454cb35ab232019461856fcdc15e09b3aa80c110dc5506de0b491250bd6"
    end
    on_intel do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.22.0/contextd_0.22.0_linux_amd64.tar.gz"
      sha256 "b7f4b9a84a9e7a0c4a74c6f8469ccbf924583f454223de7cdcdbc161944a7991"
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
