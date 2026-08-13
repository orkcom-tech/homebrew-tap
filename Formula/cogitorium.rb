# Template filled by scripts/ci/publish-packages.sh. The canonical formula lives in
# https://github.com/orkcom-tech/homebrew-tap and is bumped after each release
# by scripts/ci/publish-packages.sh — this file is here so the dependency and
# the caveat can be reviewed alongside the code they describe.
class Cogitorium < Formula
  desc "A workbench for agentic development. Local-first, no telemetry"
  homepage "https://orkcom-tech.github.io/cogitorium/"
  license "BUSL-1.1"
  version "0.4.0"

  # Contextverse is a real dependency, declared rather than described.
  # Context and memory are stored and versioned by contextd; without it the
  # server starts and says so, and memory does not work. Homebrew can express
  # that, so it does — requirement 15 is "installs together with Contextverse",
  # and on this channel that means the package manager brings it.
  depends_on "orkcom-tech/tap/contextd"

  on_macos do
    on_arm do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v0.4.0/cogitorium_0.4.0_darwin_arm64.tar.gz"
      sha256 "8ba49606b99338ec09170e2b3592a328b715c060be11c9dadc697c6e8837f9df"
    end
    on_intel do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v0.4.0/cogitorium_0.4.0_darwin_amd64.tar.gz"
      sha256 "bd15317069b9570da0cc4dd10b9a81be85eb4d09bc483f0d49dc1592a4568d26"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v0.4.0/cogitorium_0.4.0_linux_arm64.tar.gz"
      sha256 "896ffba146ad94cfb46a1198699aced7d8e7920e92d02603453a1a956a0983f1"
    end
    on_intel do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v0.4.0/cogitorium_0.4.0_linux_amd64.tar.gz"
      sha256 "b86e8aa583200b4f58f7f75cf4aedabc6957c6507f9d262590877cb0a3fc3744"
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
