# Template filled by scripts/ci/publish-packages.sh. The canonical formula lives in
# https://github.com/orkcom-tech/homebrew-tap and is bumped after each release
# by scripts/ci/publish-packages.sh — this file is here so the dependency and
# the caveat can be reviewed alongside the code they describe.
class Cogitorium < Formula
  desc "A workbench for agentic development. Local-first, no telemetry"
  homepage "https://orkcom-tech.github.io/cogitorium/"
  license "BUSL-1.1"
  version "0.1.3"

  # Contextverse is a real dependency, declared rather than described.
  # Context and memory are stored and versioned by contextd; without it the
  # server starts and says so, and memory does not work. Homebrew can express
  # that, so it does — requirement 15 is "installs together with Contextverse",
  # and on this channel that means the package manager brings it.
  depends_on "orkcom-tech/tap/contextd"

  on_macos do
    on_arm do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v0.1.3/cogitorium_0.1.3_darwin_arm64.tar.gz"
      sha256 "e5175936003d901f379d48c7941ca2921fc2b5cc53a18bb76a6b956b13f1cd0f"
    end
    on_intel do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v0.1.3/cogitorium_0.1.3_darwin_amd64.tar.gz"
      sha256 "d8df37be7fdf78100bcf047779d6ef3e6daa2adb892eaa1ba5ed44580e47c792"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v0.1.3/cogitorium_0.1.3_linux_arm64.tar.gz"
      sha256 "499d4c365013d90083f56b81c5df521c7f3e00b694340fb78e138c6826ecdb46"
    end
    on_intel do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v0.1.3/cogitorium_0.1.3_linux_amd64.tar.gz"
      sha256 "75d4f4194abbd37425dd60fd82967b9cd27dca2fcbdad415e3ef99fbdd404b4b"
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
