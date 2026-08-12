# Template filled by scripts/ci/publish-packages.sh. The canonical formula lives in
# https://github.com/orkcom-tech/homebrew-tap and is bumped after each release
# by scripts/ci/publish-packages.sh — this file is here so the dependency and
# the caveat can be reviewed alongside the code they describe.
class Cogitorium < Formula
  desc "A workbench for agentic development. Local-first, no telemetry"
  homepage "https://orkcom-tech.github.io/cogitorium/"
  license "BUSL-1.1"
  version "0.2.0"

  # Contextverse is a real dependency, declared rather than described.
  # Context and memory are stored and versioned by contextd; without it the
  # server starts and says so, and memory does not work. Homebrew can express
  # that, so it does — requirement 15 is "installs together with Contextverse",
  # and on this channel that means the package manager brings it.
  depends_on "orkcom-tech/tap/contextd"

  on_macos do
    on_arm do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v0.2.0/cogitorium_0.2.0_darwin_arm64.tar.gz"
      sha256 "4d8471a5e484d78a6f13de7c80a39e5bd477b7eeec84be53ffa209642c159e1f"
    end
    on_intel do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v0.2.0/cogitorium_0.2.0_darwin_amd64.tar.gz"
      sha256 "af34a5d8a02fa3cfccdfad68f9d9fea7e9014ce0fbaa5a2f30dc25bf7b40b3b1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v0.2.0/cogitorium_0.2.0_linux_arm64.tar.gz"
      sha256 "22e574b42b04d41163292ab2b21f225f85ac17f4b2526473de3b2c33d72c7a33"
    end
    on_intel do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v0.2.0/cogitorium_0.2.0_linux_amd64.tar.gz"
      sha256 "de9984e288ca397073f7fff0faf9cbd19e685e79f85dc5f0dbda20c9a6041142"
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
