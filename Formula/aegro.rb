class Aegro < Formula
  include Language::Python::Virtualenv

  desc "CLI for Aegro agricultural management API"
  homepage "https://pypi.org/project/aegro/"
  url "https://files.pythonhosted.org/packages/9d/89/518c31cef089efde3c48d510a167b47031b35e7875b50f08c8ad77da746a/aegro-0.18.0.tar.gz"
  sha256 "39aa4c4e73f965e181e851cc9b4e3d0902e45415ff990ce026b3c6a59842007b"
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
