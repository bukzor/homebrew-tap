class Xq < Formula
  desc "Command-line XML and HTML beautifier and content extractor (bukzor's patched version)"
  homepage "https://github.com/bukzor/xq"
  url "https://github.com/bukzor/xq.git",
      revision: "33a4703d721b3120135fd1946130b02f20719545"
  version "1.2.1-bukzor2"
  license "MIT"

  head "https://github.com/bukzor/xq.git", branch: "all-fixes"

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    ldflags = %W[
      -s -w
      -X main.commit=#{Utils.git_head}
      -X main.version=#{version}
      -X main.date=#{time.iso8601}
    ]

    system "go", "build", *std_go_args(ldflags: ldflags)
    man1.install "docs/xq.man" => "xq.1"
  end

  test do
    version_output = shell_output(bin/"xq --version 2>&1")
    assert_match "xq version #{version}", version_output

    run_output = pipe_output(bin/"xq", "<root></root>")
    assert_match("<root/>", run_output)

    # Test issue #160 fix: HTML entity escaping
    html_output = pipe_output(bin/"xq --no-color", "<html>1 &amp; 2</html>")
    assert_match "&amp;", html_output

    # Test issue #160 fix: CDATA support
    cdata_output = pipe_output(bin/"xq --no-color", "<root><![CDATA[test]]></root>")
    assert_match "test", cdata_output
  end
end
