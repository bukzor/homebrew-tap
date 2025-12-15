class GitCommitStaged < Formula
  desc "Commit staged changes at specific paths only (unlike git commit -- paths)"
  homepage "https://github.com/bukzor/git-partial.prototyping"
  url "https://github.com/bukzor/git-partial.prototyping.git",
      branch: "main"
  version "0.1.0"
  license "MIT"

  head "https://github.com/bukzor/git-partial.prototyping.git", branch: "main"

  depends_on "rust" => :build

  def install
    cd "git-commit-staged" do
      system "cargo", "build", "--release"
      bin.install "target/release/git-commit-staged"
      man1.install "man/git-commit-staged.1"
    end
  end

  test do
    # Test help flag works
    output = shell_output("#{bin}/git-commit-staged -h 2>&1")
    assert_match "Commit staged changes at specific paths only", output

    # Test it requires a git repo
    output = shell_output("#{bin}/git-commit-staged . 2>&1", 1)
    assert_match(/could not find repository|not a git repository/i, output)
  end
end
