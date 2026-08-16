# Template filled by scripts/ci/publish-packages.sh. The canonical formula lives in
# https://github.com/orkcom-tech/homebrew-tap and is bumped after each release
# by scripts/ci/publish-packages.sh — this file is here so the dependency and
# the caveat can be reviewed alongside the code they describe.
class Cogitorium < Formula
  desc "Modular workbench for deterministic, repeatable workflows built on models"
  homepage "https://orkcom-tech.github.io/cogitorium/"
  license "Apache-2.0"
  version "0.13.0"

  # Contextverse is a real dependency, declared rather than described.
  # Context and memory are stored and versioned by contextd; without it the
  # server starts and says so, and memory does not work. Homebrew can express
  # that, so it does — requirement 15 is "installs together with Contextverse",
  # and on this channel that means the package manager brings it.
  depends_on "orkcom-tech/tap/contextd"

  on_macos do
    on_arm do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v0.13.0/cogitorium_0.13.0_darwin_arm64.tar.gz"
      sha256 "947ec109cc042558d25676bc11f8c4b187afff22483acb831ff7e9815ebafc35"
    end
    on_intel do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v0.13.0/cogitorium_0.13.0_darwin_amd64.tar.gz"
      sha256 "73efb984dafd23bca9c8d6b8153cf902bccf5a091d047260ec3e5a8fc6cf8468"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v0.13.0/cogitorium_0.13.0_linux_arm64.tar.gz"
      sha256 "486bab3579433179c4bee5d5a47fc934d4c1a8c0bc77b67ad557346ec6093bde"
    end
    on_intel do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v0.13.0/cogitorium_0.13.0_linux_amd64.tar.gz"
      sha256 "ed6f7124f4c715cda46ac85dca48e6bb7de008b83aaeedf15996267970f40ba0"
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
