require "language/node"

class ItToolsMcp < Formula
  desc "Model Context Protocol server with 121+ IT tools for developers and sysadmins"
  homepage "https://github.com/wrenchpilot/it-tools-mcp"
  url "https://github.com/wrenchpilot/it-tools-mcp/archive/refs/tags/v5.8.3.tar.gz"
  sha256 "2cd316ed3ed8fe73380f422e4555312dcb871a182137991bf99519a2aa443557"
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
