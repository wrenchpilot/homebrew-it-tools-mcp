require "language/node"

class ItToolsMcp < Formula
  desc "Model Context Protocol server with 121+ IT tools for developers and sysadmins"
  homepage "https://github.com/wrenchpilot/it-tools-mcp"
  url "https://github.com/wrenchpilot/it-tools-mcp/archive/refs/tags/v5.2.8.tar.gz"
  sha256 "1e412222159a628ffc9a94350b4e84b23cf664b104aa8539f7dee8cf3fd3e9ca"
  license "MIT"

  depends_on "node"

  def install
    # Install dependencies
    system "npm", "install"
    
    # Build the project
    system "npm", "run", "build"
    
    # Install to libexec using npm pack/install approach
    libexec.install Dir["*"]
    
    # Create the bin symlink to the built executable
    bin.install_symlink libexec/"build/index.js" => "it-tools-mcp"
  end

  test do
    # Test that the MCP server can start and show some output
    output = shell_output("echo '{}' | timeout 2s #{bin}/it-tools-mcp 2>&1 || true")
    assert_match(/it-tools-mcp|MCP|tool|server/i, output)
  end
end
