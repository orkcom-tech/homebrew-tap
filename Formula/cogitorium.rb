# Template filled by scripts/ci/publish-packages.sh. The canonical formula lives in
# https://github.com/orkcom-tech/homebrew-tap and is bumped after each release
# by scripts/ci/publish-packages.sh — this file is here so the dependency and
# the caveat can be reviewed alongside the code they describe.
class Cogitorium < Formula
  desc "A workbench for agentic development. Local-first, no telemetry"
  homepage "https://orkcom-tech.github.io/cogitorium/"
  license "BUSL-1.1"
  version "0.3.0"

  # Contextverse is a real dependency, declared rather than described.
  # Context and memory are stored and versioned by contextd; without it the
  # server starts and says so, and memory does not work. Homebrew can express
  # that, so it does — requirement 15 is "installs together with Contextverse",
  # and on this channel that means the package manager brings it.
  depends_on "orkcom-tech/tap/contextd"

  on_macos do
    on_arm do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v0.3.0/cogitorium_0.3.0_darwin_arm64.tar.gz"
      sha256 "94936477493611b8ad2117202711bd3cc273d95137f838ae66803b3923ae4e81"
    end
    on_intel do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v0.3.0/cogitorium_0.3.0_darwin_amd64.tar.gz"
      sha256 "5b8352780e23a0d5b62a4d1b71a7dbf5e206ab893899120ac85ff7bddbfcf9e5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v0.3.0/cogitorium_0.3.0_linux_arm64.tar.gz"
      sha256 "720e92c30803af0a6de232a45462a406612cb2db0b14223c672fd3aec626a9e7"
    end
    on_intel do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v0.3.0/cogitorium_0.3.0_linux_amd64.tar.gz"
      sha256 "82200238504718ddf5777608d5662fd5cedc76ec6b561cd660c0ec20ce64ccab"
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
