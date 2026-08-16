# Template filled by scripts/ci/publish-packages.sh. The canonical formula lives in
# https://github.com/orkcom-tech/homebrew-tap and is bumped after each release
# by scripts/ci/publish-packages.sh — this file is here so the dependency and
# the caveat can be reviewed alongside the code they describe.
class Cogitorium < Formula
  desc "Modular workbench for deterministic, repeatable workflows built on models"
  homepage "https://orkcom-tech.github.io/cogitorium/"
  license "Apache-2.0"
  version "1.0.0"

  # Contextverse is a real dependency, declared rather than described.
  # Context and memory are stored and versioned by contextd; without it the
  # server starts and says so, and memory does not work. Homebrew can express
  # that, so it does — requirement 15 is "installs together with Contextverse",
  # and on this channel that means the package manager brings it.
  depends_on "orkcom-tech/tap/contextd"

  on_macos do
    on_arm do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v1.0.0/cogitorium_1.0.0_darwin_arm64.tar.gz"
      sha256 "49c04b13d5f7cdf15cf66dd15aa87212110549e6ff6b53a6e07809d6209226a9"
    end
    on_intel do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v1.0.0/cogitorium_1.0.0_darwin_amd64.tar.gz"
      sha256 "e4f89a8a1387348e1150615ffdaf73e41b080aeea2cfe1258c8e3e0867e0236d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v1.0.0/cogitorium_1.0.0_linux_arm64.tar.gz"
      sha256 "b11cd02ef402185598047df27f4e932329c2e2cc6e72f682b7cb5b33d7610b54"
    end
    on_intel do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v1.0.0/cogitorium_1.0.0_linux_amd64.tar.gz"
      sha256 "aa13c742f677e6597a51b79e04363fbd176779719d968cfedc72534bd5fb419c"
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
