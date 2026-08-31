class Aegro < Formula
  include Language::Python::Virtualenv

  desc "CLI for Aegro agricultural management API"
  homepage "https://pypi.org/project/aegro/"
  url "https://files.pythonhosted.org/packages/89/ae/2c92d205d3b9ec0dcaab231e8941badeff2fc93697bdbd71633ca059fb27/aegro-0.23.0.tar.gz"
  sha256 "6cdee0ea185efc78667baf54a238d58abaac67b4580680aaa3980c82a2763513"
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
