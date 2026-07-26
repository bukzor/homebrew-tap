class Sub < Formula
  desc "Organize groups of scripts into documented CLIs with subcommands"
  homepage "https://github.com/juanibiapina/sub"
  url "https://github.com/juanibiapina/sub/archive/refs/tags/v2.3.0.tar.gz"
  sha256 "35ad91bac20a33f82890702ebdc3f7012ba269058690e31ca1dc8a221b4229fd"
  license "MIT"

  head "https://github.com/juanibiapina/sub.git", branch: "master"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "Usage", shell_output("#{bin}/sub --help")
  end
end
