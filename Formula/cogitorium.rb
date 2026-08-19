# Template filled by scripts/ci/publish-packages.sh. The canonical formula lives in
# https://github.com/orkcom-tech/homebrew-tap and is bumped after each release
# by scripts/ci/publish-packages.sh — this file is here so the dependency and
# the caveat can be reviewed alongside the code they describe.
class Cogitorium < Formula
  desc "Modular workbench for deterministic, repeatable workflows built on models"
  homepage "https://orkcom-tech.github.io/cogitorium/"
  license "Apache-2.0"
  version "3.0.0"

  # Contextverse is a real dependency, declared rather than described.
  # Context and memory are stored and versioned by contextd; without it the
  # server starts and says so, and memory does not work. Homebrew can express
  # that, so it does — requirement 15 is "installs together with Contextverse",
  # and on this channel that means the package manager brings it.
  depends_on "orkcom-tech/tap/contextd"

  on_macos do
    on_arm do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v3.0.0/cogitorium_3.0.0_darwin_arm64.tar.gz"
      sha256 "453fffc716cb2ab8015ab3b1d69f979928e66713af1423b16db290ff769912eb"
    end
    on_intel do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v3.0.0/cogitorium_3.0.0_darwin_amd64.tar.gz"
      sha256 "6580b962ae97694232ad5813e91a46f65fa2bea75a9a23585ded4042b98f08d3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v3.0.0/cogitorium_3.0.0_linux_arm64.tar.gz"
      sha256 "8db9f40860cb683c5408e01b0bd18163f2926cbabbe89ac2e495f2b818abeae2"
    end
    on_intel do
      url "https://github.com/orkcom-tech/cogitorium/releases/download/v3.0.0/cogitorium_3.0.0_linux_amd64.tar.gz"
      sha256 "2fc8e68db2f2338fba35a1b4b9551df0a2a828c04f738da91956e92df1e082ab"
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
