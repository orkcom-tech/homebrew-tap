# frozen_string_literal: true

class Contextd < Formula
  desc "Portable, vendor-neutral context for AI"
  homepage "https://github.com/orkcom-tech/contextverse"
  version "0.25.0"
  license "BUSL-1.1"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    on_arm do
      url "https://github.com/orkcom-tech/contextverse/releases/download/v0.25.0/contextd_0.25.0_darwin_arm64.tar.gz"
      sha256 "346460417a49ab7c5a1b74fb05676e53cecf774de6cebc2245b505049f5c4938"
    end
    on_intel do
      url "https://github.com/orkcom-tech/contextverse/releases/download/v0.25.0/contextd_0.25.0_darwin_amd64.tar.gz"
      sha256 "11ab88552ca47f82a78b893e23312fb1df05d53a4274164cb837d725739e28e3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/orkcom-tech/contextverse/releases/download/v0.25.0/contextd_0.25.0_linux_arm64.tar.gz"
      sha256 "0371c7b1f130fcdad8410878b0274993be7676118f80b4e73553cf7caca984e7"
    end
    on_intel do
      url "https://github.com/orkcom-tech/contextverse/releases/download/v0.25.0/contextd_0.25.0_linux_amd64.tar.gz"
      sha256 "4e31fc7377cb9dce8fc626565ee3efac8b45bb9d54e131221b04e869da078b03"
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
