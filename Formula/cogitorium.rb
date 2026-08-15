# Template filled by scripts/ci/publish-packages.sh. The canonical formula lives in
# https://github.com/orkcom-tech/homebrew-tap and is bumped after each release
# by scripts/ci/publish-packages.sh — this file is here so the dependency and
# the caveat can be reviewed alongside the code they describe.
class Cogitorium < Formula
  desc "Modular workbench for deterministic, repeatable workflows built on models"
  homepage "https://orkcom-tech.github.io/cogitorium/"
  license "Apache-2.0"
  version "0.7.0"

  # Contextverse is a real dependency, declared rather than described.
  # Context and memory are stored and versioned by contextd; without it the
  # server starts and says so, and memory does not work. Homebrew can express
  # that, so it does — requirement 15 is "installs together with Contextverse",
  # and on this channel that means the package manager brings it.
  depends_on "orkcom-tech/tap/contextd"

  on_macos do
    on_arm do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v0.7.0/cogitorium_0.7.0_darwin_arm64.tar.gz"
      sha256 "64787647ed08e8610dfb4b95b64b11455a6a5ca4748925e9c97eb2e1813707c5"
    end
    on_intel do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v0.7.0/cogitorium_0.7.0_darwin_amd64.tar.gz"
      sha256 "a24c7fa1966943049dd34614afd1f8495b0656e4887007ec88157c9d0cc29125"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v0.7.0/cogitorium_0.7.0_linux_arm64.tar.gz"
      sha256 "9129b7d878856f25a13faa4a275475018ee4a6f4220e04da959cb2f5f2220732"
    end
    on_intel do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v0.7.0/cogitorium_0.7.0_linux_amd64.tar.gz"
      sha256 "0fef29faea69d46cfad68a36ab4ea641e03d31e86edf1e5e582a180e60561340"
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
