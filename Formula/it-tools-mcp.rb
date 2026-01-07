require "language/node"

class ItToolsMcp < Formula
  desc "Model Context Protocol server with 121+ IT tools for developers and sysadmins"
  homepage "https://github.com/wrenchpilot/it-tools-mcp"
  url "https://github.com/wrenchpilot/it-tools-mcp/archive/refs/tags/v5.8.6.tar.gz"
  sha256 "3034f254190c4526b7c67ff6877294bdf4cfacf7b90d09401f7dd72f9c9a4cd2"
  license "MIT"

  depends_on "node"

  def install
    # Install dependencies and build using standard Node helpers
    system "npm", "install", *std_npm_args
    system "npm", "run", "build" if (libexec/"package.json").exist?

    # Symlink the package executables
    bin.install_symlink Dir[libexec/"bin/*"]
  end

  test do
    # Basic sanity checks: package.json exists and the installed bin is presen
    assert_predicate libexec/"package.json", :exist?
    assert_match version.to_s, (libexec/"package.json").read
    assert_predicate bin/"it-tools-mcp", :exist?
  end
end
