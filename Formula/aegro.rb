class Aegro < Formula
  include Language::Python::Virtualenv

  desc "CLI for Aegro agricultural management API"
  homepage "https://pypi.org/project/aegro/"
  url "https://files.pythonhosted.org/packages/60/a1/ace231e6147cde3c74cc055e8d95e6bbd6e53819a4630440ef21194f519a/aegro-0.15.0.tar.gz"
  sha256 "42aec6139e58533dfe370fc756bc4b22efb08caebbc009ba05391d55bea001e8"
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
