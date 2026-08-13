# Template filled by scripts/ci/publish-packages.sh. The canonical formula lives in
# https://github.com/orkcom-tech/homebrew-tap and is bumped after each release
# by scripts/ci/publish-packages.sh — this file is here so the dependency and
# the caveat can be reviewed alongside the code they describe.
class Cogitorium < Formula
  desc "A workbench for agentic development. Local-first, no telemetry"
  homepage "https://orkcom-tech.github.io/cogitorium/"
  license "BUSL-1.1"
  version "0.4.1"

  # Contextverse is a real dependency, declared rather than described.
  # Context and memory are stored and versioned by contextd; without it the
  # server starts and says so, and memory does not work. Homebrew can express
  # that, so it does — requirement 15 is "installs together with Contextverse",
  # and on this channel that means the package manager brings it.
  depends_on "orkcom-tech/tap/contextd"

  on_macos do
    on_arm do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v0.4.1/cogitorium_0.4.1_darwin_arm64.tar.gz"
      sha256 "246bcaca7a919f67c72db063d19e9c070f9abe58ae36b15f33b7f003a42efd53"
    end
    on_intel do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v0.4.1/cogitorium_0.4.1_darwin_amd64.tar.gz"
      sha256 "091a1e61e6f1c94231d14f32a0214ca83511aafd9ca1f3f3df0d0bae277aa15f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v0.4.1/cogitorium_0.4.1_linux_arm64.tar.gz"
      sha256 "48388765b91d79bd5261443140a6a01703bf843847051bbfa25c5b20d4e52ded"
    end
    on_intel do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v0.4.1/cogitorium_0.4.1_linux_amd64.tar.gz"
      sha256 "ba3e66e286468eca4f4f51a18dfa43d8866f42528398f16cdf2e2946b6acbaab"
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
