class Noobaa < Formula
  desc "CLI for managing NooBaa S3 service on Kubernetes/Openshift"
  homepage "https://github.com/noobaa/noobaa-operator"
  url "https://github.com/noobaa/noobaa-operator.git",
      :tag      => "v2.1.1",
      :revision => "d82fa75ba565b42e464b23f64da779c179648cd9"
  head "https://github.com/noobaa/noobaa-operator.git"

  bottle do
    root_url "https://github.com/noobaa/homebrew-noobaa/releases/download/v2.1.1"
    cellar :any_skip_relocation
    sha256 "e10d2cc8861772a5a7476bc9cf4100e1c4a9eef989ecd8cc4a7004fe7da29d84" => :mojave
  end
  
  depends_on "go" => [:build, :test]

  def install
    ENV["GOPATH"] = buildpath
    ENV["GO111MODULE"] = "on"
    ENV["GOPROXY"] = "https://proxy.golang.org"

    src = buildpath/"src/github.com/noobaa/noobaa-operator"
    src.install buildpath.children
    src.cd do
      system "go", "mod", "vendor"
      system "go", "generate"
      system "go", "build"
      bin.install "noobaa-operator" => "noobaa"
    end
  end

  test do
    output = `#{bin}/noobaa version 2>&1`
    pos = output.index "CLI version: 2.1.1"
    raise "Version check failed" if pos.nil?

    puts "Success"
  end
end
