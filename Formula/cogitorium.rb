# Template filled by scripts/ci/publish-packages.sh. The canonical formula lives in
# https://github.com/orkcom-tech/homebrew-tap and is bumped after each release
# by scripts/ci/publish-packages.sh — this file is here so the dependency and
# the caveat can be reviewed alongside the code they describe.
class Cogitorium < Formula
  desc "Modular workbench for deterministic, repeatable workflows built on models"
  homepage "https://orkcom-tech.github.io/cogitorium/"
  license "Apache-2.0"
  version "1.0.1"

  # Contextverse is a real dependency, declared rather than described.
  # Context and memory are stored and versioned by contextd; without it the
  # server starts and says so, and memory does not work. Homebrew can express
  # that, so it does — requirement 15 is "installs together with Contextverse",
  # and on this channel that means the package manager brings it.
  depends_on "orkcom-tech/tap/contextd"

  on_macos do
    on_arm do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v1.0.1/cogitorium_1.0.1_darwin_arm64.tar.gz"
      sha256 "707547a0526f935aaa551a72a90066296f83d9858c6011a9859b791c02a48cc4"
    end
    on_intel do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v1.0.1/cogitorium_1.0.1_darwin_amd64.tar.gz"
      sha256 "a1856f02d70976df221d254343225b38df5947974579998b3a2221c7f4bb3cae"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v1.0.1/cogitorium_1.0.1_linux_arm64.tar.gz"
      sha256 "8b8c03ceb5bfde7e93aed5f904ecd9465069cf437bac2c2e7ef48d685bee1d01"
    end
    on_intel do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v1.0.1/cogitorium_1.0.1_linux_amd64.tar.gz"
      sha256 "2062227dbb82b974f6df573a0eba72e0a368f30c6048ad236f060fa2550d139c"
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
