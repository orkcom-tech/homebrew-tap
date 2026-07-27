# frozen_string_literal: true

class Contextd < Formula
  desc "Portable, vendor-neutral context for AI"
  homepage "https://github.com/abyssmemes/contextverse"
  version "0.9.0"
  license "BUSL-1.1"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    on_arm do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.9.0/contextd_0.9.0_darwin_arm64.tar.gz"
      sha256 "44b53e15ac9fb7ae590974867254479f75ec54b591a201e4833ef1955cd1ea13"
    end
    on_intel do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.9.0/contextd_0.9.0_darwin_amd64.tar.gz"
      sha256 "e2fec69de38f9459981a13ee11ff7da3176c4949a3a59375c60b0d7912e18823"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.9.0/contextd_0.9.0_linux_arm64.tar.gz"
      sha256 "9be2647a23a23cdbf12521e909cf94d05f032ec4ebfe030dc12c690cd062d0f1"
    end
    on_intel do
      url "https://github.com/abyssmemes/contextverse/releases/download/v0.9.0/contextd_0.9.0_linux_amd64.tar.gz"
      sha256 "ff355b8ad8ccd9d091ac605d7329b428460ec87684c001d6ae00bdef06d26316"
    end
  end

  def install
    bin.install "contextd"
  end

  def caveats
    <<~EOS
      contextd is licensed under BUSL-1.1 (source-available).
      You may self-host and use it in production; you may not offer it as a
      competing hosted service. Each version converts to Apache-2.0 after 4 years.

      Quick start:
        contextd init solo
        cd <project> && contextd activate
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/contextd version")
  end
end
