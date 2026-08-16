# Template filled by scripts/ci/publish-packages.sh. The canonical formula lives in
# https://github.com/orkcom-tech/homebrew-tap and is bumped after each release
# by scripts/ci/publish-packages.sh — this file is here so the dependency and
# the caveat can be reviewed alongside the code they describe.
class Cogitorium < Formula
  desc "Modular workbench for deterministic, repeatable workflows built on models"
  homepage "https://orkcom-tech.github.io/cogitorium/"
  license "Apache-2.0"
  version "0.15.0"

  # Contextverse is a real dependency, declared rather than described.
  # Context and memory are stored and versioned by contextd; without it the
  # server starts and says so, and memory does not work. Homebrew can express
  # that, so it does — requirement 15 is "installs together with Contextverse",
  # and on this channel that means the package manager brings it.
  depends_on "orkcom-tech/tap/contextd"

  on_macos do
    on_arm do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v0.15.0/cogitorium_0.15.0_darwin_arm64.tar.gz"
      sha256 "3ab1e7e2cbc16fb2cf8672df60321cb02b9843aae1e3b78de74fcfa7c9db095b"
    end
    on_intel do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v0.15.0/cogitorium_0.15.0_darwin_amd64.tar.gz"
      sha256 "bf58e9dec32298a8f61b314afe0bddaa9cd442b0d94253dbf6f9d63810c3be8b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v0.15.0/cogitorium_0.15.0_linux_arm64.tar.gz"
      sha256 "f5975885caf11166a47e04e93ace2920223f1f179058ebc02336f2cd8cba1628"
    end
    on_intel do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v0.15.0/cogitorium_0.15.0_linux_amd64.tar.gz"
      sha256 "c16bfb38ff45d9405b2ba5f8be71e99627d5f4dfb3b44e12d366ec295d1975af"
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
