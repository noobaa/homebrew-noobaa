class Noobaa < Formula
  desc "CLI for managing NooBaa S3 service on Kubernetes/Openshift"
  homepage "https://github.com/noobaa/noobaa-operator"
  url "https://github.com/noobaa/noobaa-operator.git",
      :tag      => "v2.0.1",
      :revision => "5973b5a82b918b2139c6a88e7d1b4cfe02d7e32d"
  head "https://github.com/noobaa/noobaa-operator.git"

  bottle do
    root_url "https://github.com/noobaa/homebrew-noobaa/releases/download/v2.0.1"
    cellar :any_skip_relocation
    sha256 "6772bebb23e23356a3a82847c69c346555105610b20cac5b92d70ed3f55e05f9" => :mojave
  end
  
  depends_on "go" => [:build, :test]

  def install
    ENV["GOPATH"] = buildpath
    ENV["GO111MODULE"] = "on"
    ENV["GOPROXY"] = "https://proxy.golang.org"

    src = buildpath/"src/github.com/noobaa/noobaa-operator"
    src.install buildpath.children
    src.cd do
      mkdir_p "./build/_output/bundle"
      File.write "./build/_output/bundle/empty.go", "package bundle"
      system "go", "mod", "vendor"
      system "go", "generate"
      system "go", "build"
      bin.install "noobaa-operator" => "noobaa"
    end
  end

  test do
    output = `#{bin}/noobaa version 2>&1`
    pos = output.index "CLI version: 2.0.1"
    raise "Version check failed" if pos.nil?

    puts "Success"
  end
end
