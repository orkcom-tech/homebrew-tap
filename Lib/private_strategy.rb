# frozen_string_literal: true

require "download_strategy"
require "utils/github"

# Download private GitHub release assets using HOMEBREW_GITHUB_API_TOKEN.
# Usage in a formula:
#   url "...", using: GitHubPrivateRepositoryReleaseDownloadStrategy
class GitHubPrivateRepositoryReleaseDownloadStrategy < CurlDownloadStrategy
  def initialize(url, name, version, **meta)
    super
    parse_url_pattern
    set_github_token
  end

  def parse_url_pattern
    url_pattern = %r{https://github.com/([^/]+)/([^/]+)/releases/download/([^/]+)/(\S+)}
    unless (match = @url.match(url_pattern))
      raise CurlDownloadStrategyError, "Invalid url pattern for GitHub Release."
    end

    _, @owner, @repo, @tag, @filename = *match
  end

  def download_url
    "https://x-access-token:#{@github_token}@github.com/#{@owner}/#{@repo}/releases/download/#{@tag}/#{@filename}"
  end

  def set_github_token
    @github_token = ENV.fetch("HOMEBREW_GITHUB_API_TOKEN", nil)
    return if @github_token

    raise CurlDownloadStrategyError,
          "Downloading private ContextVerse releases requires " \
          "HOMEBREW_GITHUB_API_TOKEN (e.g. export HOMEBREW_GITHUB_API_TOKEN=\"$(gh auth token)\")."
  end

  def _fetch(url:, resolved_url:, timeout:)
    curl_download download_url, to: temporary_path, timeout: timeout
  end
end
