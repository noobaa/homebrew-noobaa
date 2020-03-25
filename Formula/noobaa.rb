class Noobaa < Formula
  desc "CLI for managing NooBaa S3 service on Kubernetes/Openshift"
  homepage "https://github.com/noobaa/noobaa-operator"
  url "https://github.com/noobaa/noobaa-operator.git",
      :tag      => "v2.1.0",
      :revision => "2783fb066d9eecc87c0e5fc29a4e0b879dd46be1"
  head "https://github.com/noobaa/noobaa-operator.git"

  bottle do
    root_url "https://github.com/noobaa/homebrew-noobaa/releases/download/v2.1.0"
    cellar :any_skip_relocation
    sha256 "38037e667f15f5e9b31a0869bc2736e22bc1e2604ac8f5bf50229f78af52b3eb" => :mojave
    # sha256 "c81f1d21a895c4c06aa47cc560c306084d2c73ae040ec073ecc8dab39ec38c15" => :catalina
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
    pos = output.index "CLI version: 2.1.0"
    raise "Version check failed" if pos.nil?

    puts "Success"
  end
end
