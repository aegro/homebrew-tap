class Aegro < Formula
  include Language::Python::Virtualenv

  desc "CLI for Aegro agricultural management API"
  homepage "https://pypi.org/project/aegro/"
  url "https://files.pythonhosted.org/packages/b7/12/54a9168e89aecee9b4bd056ae8bb468b99112c7d77bdc0c7f03c3f093f84/aegro-0.29.0.tar.gz"
  sha256 "81a11572e3540edecebde832000ae7d106b27bdc4038df70980ef20a7a985c6f"
  license "MIT"

  depends_on "python@3.12"

  def install
    virtualenv_create(libexec, "python3.12")
    # Wrapper script so Homebrew tracks the bin entry.
    # Actual package is installed in post_install to avoid
    # dylib relocation errors on pydantic_core's .so files.
    (bin/"aegro").write_env_script(
      libexec/"bin/aegro",
      PATH: "#{libexec}/bin:${PATH}",
    )
  end

  def post_install
    system Formula["python@3.12"].opt_bin/"python3.12", "-m", "pip",
           "--python=#{libexec}/bin/python",
           "install", "aegro==#{version}"
  end

  test do
    assert_match "Usage", shell_output("#{bin}/aegro --help")
  end
end
