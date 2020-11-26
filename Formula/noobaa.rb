class Noobaa < Formula
  desc "CLI for managing NooBaa S3 service on Kubernetes/Openshift"
  homepage "https://github.com/noobaa/noobaa-operator"
  url "https://github.com/noobaa/noobaa-operator.git",
      :tag      => "v5.6.0",
      :revision => "706b32adeeb5c59c5657b363ea1274401261ed95"
  head "https://github.com/noobaa/noobaa-operator.git"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-noobaa"
    cellar :any_skip_relocation
    sha256 "c43b27a197685d6bba31bf734be5f3647c1d8eda260bd56b00fb587d1a0e586c" => :mojave
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
    pos = output.index "CLI version: 5.6.0"
    raise "Version check failed" if pos.nil?

    puts "Success"
  end
end
