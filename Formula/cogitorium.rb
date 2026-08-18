# Template filled by scripts/ci/publish-packages.sh. The canonical formula lives in
# https://github.com/orkcom-tech/homebrew-tap and is bumped after each release
# by scripts/ci/publish-packages.sh — this file is here so the dependency and
# the caveat can be reviewed alongside the code they describe.
class Cogitorium < Formula
  desc "Modular workbench for deterministic, repeatable workflows built on models"
  homepage "https://orkcom-tech.github.io/cogitorium/"
  license "Apache-2.0"
  version "1.5.0"

  # Contextverse is a real dependency, declared rather than described.
  # Context and memory are stored and versioned by contextd; without it the
  # server starts and says so, and memory does not work. Homebrew can express
  # that, so it does — requirement 15 is "installs together with Contextverse",
  # and on this channel that means the package manager brings it.
  depends_on "orkcom-tech/tap/contextd"

  on_macos do
    on_arm do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v1.5.0/cogitorium_1.5.0_darwin_arm64.tar.gz"
      sha256 "499aa7aa90d1e78ec66392b38c2e9f2092079a847df5d55b2a67706ddf68b707"
    end
    on_intel do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v1.5.0/cogitorium_1.5.0_darwin_amd64.tar.gz"
      sha256 "a4aa44d93eb8e3230b4142400fac2cc9c338b6af404481495214e89ad39f5b38"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v1.5.0/cogitorium_1.5.0_linux_arm64.tar.gz"
      sha256 "fead91e4be0b09640ffc556c8aa2e786e785b732899c45d3a8d6e2b5e14713d8"
    end
    on_intel do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v1.5.0/cogitorium_1.5.0_linux_amd64.tar.gz"
      sha256 "d6bde35b3e63011480e16ee7ab529d7c1bb48375ff6cc684ea98645df9b4a244"
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
