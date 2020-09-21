class Noobaa < Formula
  desc "CLI for managing NooBaa S3 service on Kubernetes/Openshift"
  homepage "https://github.com/noobaa/noobaa-operator"
  url "https://github.com/noobaa/noobaa-operator.git",
      :tag      => "v2.3.0",
      :revision => "25a29375c96d417c971131abc478650da5584c4f"
  head "https://github.com/noobaa/noobaa-operator.git"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-noobaa"
    cellar :any_skip_relocation
    sha256 "3af01b23231a7e7f40b6319ae7cafd8d6f8a889f6d930664ed6ec7314b9d2991" => :mojave
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
    pos = output.index "CLI version: 2.3.0"
    raise "Version check failed" if pos.nil?

    puts "Success"
  end
end
