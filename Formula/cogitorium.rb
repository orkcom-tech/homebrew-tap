# Template filled by scripts/ci/publish-packages.sh. The canonical formula lives in
# https://github.com/orkcom-tech/homebrew-tap and is bumped after each release
# by scripts/ci/publish-packages.sh — this file is here so the dependency and
# the caveat can be reviewed alongside the code they describe.
class Cogitorium < Formula
  desc "Modular workbench for deterministic, repeatable workflows built on models"
  homepage "https://orkcom-tech.github.io/cogitorium/"
  license "Apache-2.0"
  version "0.8.0"

  # Contextverse is a real dependency, declared rather than described.
  # Context and memory are stored and versioned by contextd; without it the
  # server starts and says so, and memory does not work. Homebrew can express
  # that, so it does — requirement 15 is "installs together with Contextverse",
  # and on this channel that means the package manager brings it.
  depends_on "orkcom-tech/tap/contextd"

  on_macos do
    on_arm do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v0.8.0/cogitorium_0.8.0_darwin_arm64.tar.gz"
      sha256 "aa4293f589daab9121b9a34ab1107a5f38ede10f670bc28d0621e1f1143abd38"
    end
    on_intel do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v0.8.0/cogitorium_0.8.0_darwin_amd64.tar.gz"
      sha256 "c9fb6ee8d58fab9c05a8201801519bc22626a9628a736860a8ab7d2cb69ef963"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v0.8.0/cogitorium_0.8.0_linux_arm64.tar.gz"
      sha256 "d065bb4e8e39dbc3bec95118b9b38d9ce2c884ff8797150251683a92c528d05d"
    end
    on_intel do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v0.8.0/cogitorium_0.8.0_linux_amd64.tar.gz"
      sha256 "9129001956196944c8679f59cf5c429dbaaf3ddcebffaae87c3f14fc295b5128"
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
