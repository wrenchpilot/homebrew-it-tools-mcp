require "language/node"

class ItToolsMcp < Formula
  desc "Model Context Protocol server with 100+ IT tools for developers/sysadmins"
  homepage "https://github.com/wrenchpilot/it-tools-mcp"
  url "https://github.com/wrenchpilot/it-tools-mcp/archive/refs/tags/v5.0.1.tar.gz"
  sha256 "0d2e4703ef58601832da03b5f0d77f8e9ccd03b825baa2c2370fbf347ebfdc8e"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_args(libexec)
    bin.install_symlink Dir[libexec/"bin/*"]
  end

  test do
    system "#{bin}/it-tools-mcp", "--version"
  end
end
