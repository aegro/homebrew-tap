class Aegro < Formula
  include Language::Python::Virtualenv

  desc "CLI for Aegro agricultural management API"
  homepage "https://github.com/aegro/tool-aegro-cli"
  url "https://github.com/aegro/tool-aegro-cli/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
  license "MIT"

  depends_on "python@3.12"

  def install
    ENV["SETUPTOOLS_SCM_PRETEND_VERSION"] = version.to_s
    virtualenv_install_with_resources
  end

  test do
    assert_match "Usage", shell_output("#{bin}/aegro --help")
  end
end
