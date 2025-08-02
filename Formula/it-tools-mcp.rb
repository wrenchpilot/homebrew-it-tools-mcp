require "language/node"

class ItToolsMcp < Formula
  livecheck do
    url :stable
    strategy :github_latest
  end
  desc "Model Context Protocol server with 100+ IT tools for developers/sysadmins"
  homepage "https://github.com/wrenchpilot/it-tools-mcp"
  url "https://github.com/wrenchpilot/it-tools-mcp/archive/refs/tags/v#{version}.tar.gz"
  sha256 e2d351efdcd69f0f51dc7f93fb4b3b42a653589c2bb042c108643e6aa19bd2d1
  version "5.0.3"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_args(libexec)
    # Symlink the CLI from build/index.js if present, otherwise from bin/
    cli = Dir[libexec/"build/index.js"].first || Dir[libexec/"bin/it-tools-mcp"].first
    bin.install_symlink cli => "it-tools-mcp" if cli
  end

  test do
    system "#{bin}/it-tools-mcp", "--version"
  end
end
