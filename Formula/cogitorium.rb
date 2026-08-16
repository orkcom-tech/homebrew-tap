# Template filled by scripts/ci/publish-packages.sh. The canonical formula lives in
# https://github.com/orkcom-tech/homebrew-tap and is bumped after each release
# by scripts/ci/publish-packages.sh — this file is here so the dependency and
# the caveat can be reviewed alongside the code they describe.
class Cogitorium < Formula
  desc "Modular workbench for deterministic, repeatable workflows built on models"
  homepage "https://orkcom-tech.github.io/cogitorium/"
  license "Apache-2.0"
  version "0.14.0"

  # Contextverse is a real dependency, declared rather than described.
  # Context and memory are stored and versioned by contextd; without it the
  # server starts and says so, and memory does not work. Homebrew can express
  # that, so it does — requirement 15 is "installs together with Contextverse",
  # and on this channel that means the package manager brings it.
  depends_on "orkcom-tech/tap/contextd"

  on_macos do
    on_arm do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v0.14.0/cogitorium_0.14.0_darwin_arm64.tar.gz"
      sha256 "377f157011ad6c3e3e7bb5b12be99a3efc81b551bd77363c494ee1b639e18ceb"
    end
    on_intel do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v0.14.0/cogitorium_0.14.0_darwin_amd64.tar.gz"
      sha256 "8389765ed00fa846f30ffb9a9961ee4ad6b7adabd6e778068206bfb56072f8d2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v0.14.0/cogitorium_0.14.0_linux_arm64.tar.gz"
      sha256 "013c77c3c4bb09c60c70c6bba9be35994cf83ad67436ccdde777aa2c48ec3a98"
    end
    on_intel do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v0.14.0/cogitorium_0.14.0_linux_amd64.tar.gz"
      sha256 "f0a3d6b0eba43950dba5e5a4b06e6814528dbf1d2698f63c8861dbc263b1bf5c"
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
