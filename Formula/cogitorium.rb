# Template filled by scripts/ci/publish-packages.sh. The canonical formula lives in
# https://github.com/orkcom-tech/homebrew-tap and is bumped after each release
# by scripts/ci/publish-packages.sh — this file is here so the dependency and
# the caveat can be reviewed alongside the code they describe.
class Cogitorium < Formula
  desc "Modular workbench for deterministic, repeatable workflows built on models"
  homepage "https://orkcom-tech.github.io/cogitorium/"
  license "Apache-2.0"
  version "3.2.0"

  # Contextverse is a real dependency, declared rather than described.
  # Context and memory are stored and versioned by contextd; without it the
  # server starts and says so, and memory does not work. Homebrew can express
  # that, so it does — requirement 15 is "installs together with Contextverse",
  # and on this channel that means the package manager brings it.
  depends_on "orkcom-tech/tap/contextd"

  on_macos do
    on_arm do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v3.2.0/cogitorium_3.2.0_darwin_arm64.tar.gz"
      sha256 "7ed1089348520ac65b57a4ef1d5a84b8d3439a706b95d400a1fed8e10ded30be"
    end
    on_intel do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v3.2.0/cogitorium_3.2.0_darwin_amd64.tar.gz"
      sha256 "973f9560b55f49bfe55849463eb30cf356af6cb83a77af3d2f16c78255fef39c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v3.2.0/cogitorium_3.2.0_linux_arm64.tar.gz"
      sha256 "becc759c04795d5b9f9dc0d99d46d037f7df916495e14d17d4080067b697f6a3"
    end
    on_intel do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v3.2.0/cogitorium_3.2.0_linux_amd64.tar.gz"
      sha256 "831681bd6baea5079c529c0f16078697ec1732ba0812ef08ee211d48868c4291"
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
