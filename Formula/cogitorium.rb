# Template filled by scripts/ci/publish-packages.sh. The canonical formula lives in
# https://github.com/orkcom-tech/homebrew-tap and is bumped after each release
# by scripts/ci/publish-packages.sh — this file is here so the dependency and
# the caveat can be reviewed alongside the code they describe.
class Cogitorium < Formula
  desc "Modular workbench for deterministic, repeatable workflows built on models"
  homepage "https://orkcom-tech.github.io/cogitorium/"
  license "Apache-2.0"
  version "0.9.0"

  # Contextverse is a real dependency, declared rather than described.
  # Context and memory are stored and versioned by contextd; without it the
  # server starts and says so, and memory does not work. Homebrew can express
  # that, so it does — requirement 15 is "installs together with Contextverse",
  # and on this channel that means the package manager brings it.
  depends_on "orkcom-tech/tap/contextd"

  on_macos do
    on_arm do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v0.9.0/cogitorium_0.9.0_darwin_arm64.tar.gz"
      sha256 "6229b0c32bb8af895c81e6b8c993e5cbb3d630909c466daa5b6c33d70522d38d"
    end
    on_intel do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v0.9.0/cogitorium_0.9.0_darwin_amd64.tar.gz"
      sha256 "f2c1a6e6a4900bd57c60aab9bde7e21499d4371a6258598aec9ae10a5abb7b67"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v0.9.0/cogitorium_0.9.0_linux_arm64.tar.gz"
      sha256 "c754371479f9f7691902ac958c7ec7beb7b56524a9675259987f8edd4c274372"
    end
    on_intel do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v0.9.0/cogitorium_0.9.0_linux_amd64.tar.gz"
      sha256 "3701a8ee9e10d9f7d5194f029b949804163e7f701891b37d808ad9337eaee83d"
    end
  end

  def install
    bin.install "cogitorium"
  end

  service do
    run [opt_bin/"cogitorium", "serve"]
    keep_alive true
    working_dir var
    log_path var/"log/cogitorium.log"
    error_log_path var/"log/cogitorium.log"
  end

  def caveats
    <<~EOS
      Start it with:
        cogitorium serve

      Then open http://127.0.0.1:8688. On a loopback address you are the admin
      and there is no login screen; the same binary asks for credentials the
      moment it listens on anything else.

      Gears and the terminal need Docker to be isolated. Without it, gears run
      with this server's own file access and the terminal refuses to open —
      the server says which at startup.
    EOS
  end

  test do
    assert_match "cogitorium", shell_output("#{bin}/cogitorium --help")
  end
end
