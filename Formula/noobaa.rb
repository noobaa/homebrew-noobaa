class Noobaa < Formula
  desc "CLI for managing NooBaa S3 service on Kubernetes/Openshift"
  homepage "https://github.com/noobaa/noobaa-operator"
  url "https://github.com/noobaa/noobaa-operator.git",
      :tag      => "v5.7.0",
      :revision => "054bc35207d5c3cae70838052b76b55149c1c260"
  head "https://github.com/noobaa/noobaa-operator.git"

  bottle do
    root_url "https://github.com/noobaa/noobaa-operator/releases/download/v5.7.0"
    sha256 cellar: :any_skip_relocation, mojave: "124ffdb1b4c9b2506da1b19b72850a3d720f03256e8352c5183620fa27d35089"
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
    pos = output.index "CLI version: 5.6.0"
    raise "Version check failed" if pos.nil?

    puts "Success"
  end
end
