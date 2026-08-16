# Template filled by scripts/ci/publish-packages.sh. The canonical formula lives in
# https://github.com/orkcom-tech/homebrew-tap and is bumped after each release
# by scripts/ci/publish-packages.sh — this file is here so the dependency and
# the caveat can be reviewed alongside the code they describe.
class Cogitorium < Formula
  desc "Modular workbench for deterministic, repeatable workflows built on models"
  homepage "https://orkcom-tech.github.io/cogitorium/"
  license "Apache-2.0"
  version "0.12.0"

  # Contextverse is a real dependency, declared rather than described.
  # Context and memory are stored and versioned by contextd; without it the
  # server starts and says so, and memory does not work. Homebrew can express
  # that, so it does — requirement 15 is "installs together with Contextverse",
  # and on this channel that means the package manager brings it.
  depends_on "orkcom-tech/tap/contextd"

  on_macos do
    on_arm do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v0.12.0/cogitorium_0.12.0_darwin_arm64.tar.gz"
      sha256 "4cde23d4ef9dc3f07f0ba1934cb9f324ae54c2eeadb795a637be6f07b8b60899"
    end
    on_intel do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v0.12.0/cogitorium_0.12.0_darwin_amd64.tar.gz"
      sha256 "a4f0c5c3f7875dc8a4805a676de79307e95441a68ed4d1449dd65244c986932a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v0.12.0/cogitorium_0.12.0_linux_arm64.tar.gz"
      sha256 "28095c981c2c0d5f73ca9ba4e844e11f1558c3d36d10e92110fb3cafe2d827a1"
    end
    on_intel do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v0.12.0/cogitorium_0.12.0_linux_amd64.tar.gz"
      sha256 "f0e6d234d8b6d7000cfa83ba5a8e1815944a2e2437673c816dc3e40a719477e1"
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
