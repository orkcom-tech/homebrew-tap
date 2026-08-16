# Template filled by scripts/ci/publish-packages.sh. The canonical formula lives in
# https://github.com/orkcom-tech/homebrew-tap and is bumped after each release
# by scripts/ci/publish-packages.sh — this file is here so the dependency and
# the caveat can be reviewed alongside the code they describe.
class Cogitorium < Formula
  desc "Modular workbench for deterministic, repeatable workflows built on models"
  homepage "https://orkcom-tech.github.io/cogitorium/"
  license "Apache-2.0"
  version "0.11.0"

  # Contextverse is a real dependency, declared rather than described.
  # Context and memory are stored and versioned by contextd; without it the
  # server starts and says so, and memory does not work. Homebrew can express
  # that, so it does — requirement 15 is "installs together with Contextverse",
  # and on this channel that means the package manager brings it.
  depends_on "orkcom-tech/tap/contextd"

  on_macos do
    on_arm do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v0.11.0/cogitorium_0.11.0_darwin_arm64.tar.gz"
      sha256 "8c9b0bac80d027e45c90db60471609f15ba6f9836b43004d72585ed4a02c3cce"
    end
    on_intel do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v0.11.0/cogitorium_0.11.0_darwin_amd64.tar.gz"
      sha256 "17ee578c49615e43e574b8931b2344dae44a48c06b5dd496f188b1085e574967"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v0.11.0/cogitorium_0.11.0_linux_arm64.tar.gz"
      sha256 "11c046fd070a1e7f199d878714055ee9260e0022e92e6f8b5188b327ced46297"
    end
    on_intel do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v0.11.0/cogitorium_0.11.0_linux_amd64.tar.gz"
      sha256 "e205d0184977dda7053648533207e43f4f7537c8c690befbb56c0c6fabc24c3b"
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
