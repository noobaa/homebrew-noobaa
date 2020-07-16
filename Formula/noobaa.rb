class Noobaa < Formula
  desc "CLI for managing NooBaa S3 service on Kubernetes/Openshift"
  homepage "https://github.com/noobaa/noobaa-operator"
  url "https://github.com/noobaa/noobaa-operator.git",
      :tag      => "v2.3.0",
      :revision => "416d6dedfb670545b345caa4083ef9ba07c2cf9a"
  head "https://github.com/noobaa/noobaa-operator.git"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-noobaa"
    cellar :any_skip_relocation
    sha256 "dfd07a1c3f2bc3b0b1f1b7d2f2f758914e51060986f8de5f7d2a5e82fbabef59" => :mojave
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
