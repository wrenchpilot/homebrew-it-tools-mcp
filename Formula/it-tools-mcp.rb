require "language/node"

class ItToolsMcp < Formula
  livecheck do
    url :stable
    strategy :github_latest
  end
  desc "Model Context Protocol server with 100+ IT tools for developers/sysadmins"
  homepage "https://github.com/wrenchpilot/it-tools-mcp"
  version "5.0.4"
  url "https://github.com/wrenchpilot/it-tools-mcp/archive/refs/tags/v#{version}.tar.gz"
  sha256 "e2d351efdcd69f0f51dc7f93fb4b3b42a653589c2bb042c108643e6aa19bd2d1"
  license "MIT"

  depends_on "node"

  def install
  system "npm", "install", *Language::Node.std_npm_install_args(libexec)
  # Explicitly symlink the CLI to Homebrew's bin
  bin.install_symlink libexec/"bin/it-tools-mcp" => "it-tools-mcp"
  end

  test do
    system "#{bin}/it-tools-mcp", "--version"
  end
end
