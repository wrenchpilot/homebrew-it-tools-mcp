class ItToolsMcp < Formula
  desc "Model Context Protocol server with 100+ IT tools for developers and sysadmins"
  homepage "https://github.com/wrenchpilot/it-tools-mcp"
  url "https://registry.npmjs.org/it-tools-mcp/-/it-tools-mcp-5.10.4.tgz"
  sha256 "a182b555334c8c88d04575571b0c03d65ae72e5526e6d8cb682b0ce442c876b9"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  test do
    # Test that the executable exists and is runnable
    assert_path_exists bin/"it-tools-mcp"

    # Verify version can be displayed
    version_output = shell_output("#{bin}/it-tools-mcp --version")
    assert_match version.to_s, version_output

    # Run built-in validation tests
    system bin/"it-tools-mcp", "--test"

    # Verify package.json exists and contains correct version
    pkg_json = libexec/"lib/node_modules/it-tools-mcp/package.json"
    assert_path_exists pkg_json
    assert_match version.to_s, pkg_json.read
  end
end
