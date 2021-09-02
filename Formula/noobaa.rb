class Noobaa < Formula
  desc "CLI for managing NooBaa S3 service on Kubernetes/Openshift"
  homepage "https://github.com/noobaa/noobaa-operator"
  url "https://github.com/noobaa/noobaa-operator.git",
      :tag      => "v5.8.0",
      :revision => "68ee9db7a0be1d53fdbbf568a6530f54735d973d"
  head "https://github.com/noobaa/noobaa-operator.git"

  bottle do
    root_url "https://github.com/noobaa/noobaa-operator/releases/download/v5.8.0"
    sha256 cellar: :any_skip_relocation, big_sur: "777db0770e29567678bde6261290099d47ffac45d7983c75efde512e4b5e1158"
    rebuild 1
  end
  
  depends_on "go" => [:build, :test]

  def install
    ENV.deparallelize # avoid parallel make jobs
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
    pos = output.index "CLI version: 5.8.0"
    raise "Version check failed" if pos.nil?

    puts "Success"
  end
end
