# Template filled by scripts/ci/publish-packages.sh. The canonical formula lives in
# https://github.com/orkcom-tech/homebrew-tap and is bumped after each release
# by scripts/ci/publish-packages.sh — this file is here so the dependency and
# the caveat can be reviewed alongside the code they describe.
class Cogitorium < Formula
  desc "Modular workbench for deterministic, repeatable workflows built on models"
  homepage "https://orkcom-tech.github.io/cogitorium/"
  license "Apache-2.0"
  version "0.5.0"

  # Contextverse is a real dependency, declared rather than described.
  # Context and memory are stored and versioned by contextd; without it the
  # server starts and says so, and memory does not work. Homebrew can express
  # that, so it does — requirement 15 is "installs together with Contextverse",
  # and on this channel that means the package manager brings it.
  depends_on "orkcom-tech/tap/contextd"

  on_macos do
    on_arm do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v0.5.0/cogitorium_0.5.0_darwin_arm64.tar.gz"
      sha256 "15c0244ffb8438cebf4d56da071e24cd5627836ee3d85f1f9b5a6761c4f116a9"
    end
    on_intel do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v0.5.0/cogitorium_0.5.0_darwin_amd64.tar.gz"
      sha256 "f020ad77c60bc0a54ad4af27b60c8fe12b3bf9556c119f0b6283620daa8c0860"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v0.5.0/cogitorium_0.5.0_linux_arm64.tar.gz"
      sha256 "056504a23c611f07f859a22b63944f96e944fe4b952e27f3e0e032fdfd45d4b6"
    end
    on_intel do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v0.5.0/cogitorium_0.5.0_linux_amd64.tar.gz"
      sha256 "a1413486d5bb82d12c4975faa0632a4b8b87fecdd9be90c421b15ae8d6e22738"
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
