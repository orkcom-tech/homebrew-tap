# Template filled by scripts/ci/publish-packages.sh. The canonical formula lives in
# https://github.com/orkcom-tech/homebrew-tap and is bumped after each release
# by scripts/ci/publish-packages.sh — this file is here so the dependency and
# the caveat can be reviewed alongside the code they describe.
class Cogitorium < Formula
  desc "Modular workbench for deterministic, repeatable workflows built on models"
  homepage "https://orkcom-tech.github.io/cogitorium/"
  license "Apache-2.0"
  version "2.0.0"

  # Contextverse is a real dependency, declared rather than described.
  # Context and memory are stored and versioned by contextd; without it the
  # server starts and says so, and memory does not work. Homebrew can express
  # that, so it does — requirement 15 is "installs together with Contextverse",
  # and on this channel that means the package manager brings it.
  depends_on "orkcom-tech/tap/contextd"

  on_macos do
    on_arm do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v2.0.0/cogitorium_2.0.0_darwin_arm64.tar.gz"
      sha256 "4e5b4fa5d1e65b2f55b37ed3d45a1e85372ce0f3781d55414fd41ac1b559f988"
    end
    on_intel do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v2.0.0/cogitorium_2.0.0_darwin_amd64.tar.gz"
      sha256 "046a924de25e6ecd086947f80b273d9d2a081dc10af291b94f1b478999607b24"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v2.0.0/cogitorium_2.0.0_linux_arm64.tar.gz"
      sha256 "cd9b8f2fc089b10375ca9225ffca9dfbea8786dedfd129129ab4176f7ca46641"
    end
    on_intel do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v2.0.0/cogitorium_2.0.0_linux_amd64.tar.gz"
      sha256 "1aa45032276e1e37f126f124ab53adbdeb713341fa4ac8f882b6d830dd0eba22"
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
