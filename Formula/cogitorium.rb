# Template filled by scripts/ci/publish-packages.sh. The canonical formula lives in
# https://github.com/orkcom-tech/homebrew-tap and is bumped after each release
# by scripts/ci/publish-packages.sh — this file is here so the dependency and
# the caveat can be reviewed alongside the code they describe.
class Cogitorium < Formula
  desc "Modular workbench for deterministic, repeatable workflows built on models"
  homepage "https://orkcom-tech.github.io/cogitorium/"
  license "Apache-2.0"
  version "0.10.0"

  # Contextverse is a real dependency, declared rather than described.
  # Context and memory are stored and versioned by contextd; without it the
  # server starts and says so, and memory does not work. Homebrew can express
  # that, so it does — requirement 15 is "installs together with Contextverse",
  # and on this channel that means the package manager brings it.
  depends_on "orkcom-tech/tap/contextd"

  on_macos do
    on_arm do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v0.10.0/cogitorium_0.10.0_darwin_arm64.tar.gz"
      sha256 "82e4d3bc51b7716d069aa1b315e17424684b412f90972eb9cf7bc3a5855d9894"
    end
    on_intel do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v0.10.0/cogitorium_0.10.0_darwin_amd64.tar.gz"
      sha256 "974004df3d2206f988c3a106df84a015cf3c54f3969382f4286da1a45a8f4ac4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v0.10.0/cogitorium_0.10.0_linux_arm64.tar.gz"
      sha256 "c9502a132265e60c970c7da63ff6faed78f8ebd8443da060b72c3ccfc990b4e7"
    end
    on_intel do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v0.10.0/cogitorium_0.10.0_linux_amd64.tar.gz"
      sha256 "269971e032e11705fd047697857968a0f00f61b12eb6af262b815bf3250b46f8"
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
