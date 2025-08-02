require "language/node"

class ItToolsMcp < Formula
  desc "Model Context Protocol server with 121+ IT tools for developers and sysadmins"
  homepage "https://github.com/wrenchpilot/it-tools-mcp"
  url "https://github.com/wrenchpilot/it-tools-mcp/archive/refs/tags/v5.0.4.tar.gz"
  sha256 "99332488a5a9aafcb74fa6a8ba93ef95d552ef4b6605503e8263f0ab93e18343"
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
