class Aegro < Formula
  include Language::Python::Virtualenv

  desc "CLI for Aegro agricultural management API"
  homepage "https://pypi.org/project/aegro/"
  url "https://files.pythonhosted.org/packages/source/a/aegro/aegro-0.4.0.tar.gz"
  sha256 "1ac6683ce711b5d8892b0b396eae2cfa7a04842a27e0317bd175d694189fa636"
  license "MIT"

  depends_on "python@3.12"

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "Usage", shell_output("#{bin}/aegro --help")
  end
end
