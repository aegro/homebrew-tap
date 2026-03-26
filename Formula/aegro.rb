class Aegro < Formula
  include Language::Python::Virtualenv

  desc "CLI for Aegro agricultural management API"
  homepage "https://pypi.org/project/aegro/"
  url "https://files.pythonhosted.org/packages/8d/22/3c15dea16c64e5d195973ffadb3496e1e80bff61dc81e9eb7e18e242402b/aegro-0.4.0.tar.gz"
  sha256 "1ac6683ce711b5d8892b0b396eae2cfa7a04842a27e0317bd175d694189fa636"
  license "MIT"

  depends_on "python@3.12"

  def install
    virtualenv_create(libexec, "python3.12")
    system Formula["python@3.12"].opt_bin/"python3.12", "-m", "pip",
           "--python=#{libexec}/bin/python",
           "install", "aegro==#{version}"
    bin.install_symlink Dir[libexec/"bin/aegro"]
  end

  test do
    assert_match "Usage", shell_output("#{bin}/aegro --help")
  end
end
