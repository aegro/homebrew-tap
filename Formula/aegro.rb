class Aegro < Formula
  include Language::Python::Virtualenv

  desc "CLI for Aegro agricultural management API"
  homepage "https://pypi.org/project/aegro/"
  url "https://files.pythonhosted.org/packages/45/dc/4802b46161c359138d5a455e78d5db87e86f40b4bd06f9ac0a71afb82b2e/aegro-0.26.0.tar.gz"
  sha256 "99540cc38c38ede58d1bf5173ff66163f64a4ffcbf31698cb00f8fd4d1bfd9f0"
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
