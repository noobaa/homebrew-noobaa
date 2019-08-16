class Noobaa < Formula
  desc "CLI for managing NooBaa S3 service on Kubernetes/Openshift"
  homepage "https://github.com/noobaa/noobaa-operator"
  url "https://github.com/noobaa/noobaa-operator.git",
      :tag      => "v1.0.2",
      :revision => "e97aff3759afc0d08f20f42484ac475570e9cd4d"
  head "https://github.com/noobaa/noobaa-operator.git"

  bottle do
    root_url "https://github.com/noobaa/homebrew-noobaa/releases/download/v1.0.2"
    rebuild 1
    cellar :any_skip_relocation
    sha256 "f3957cea96857e8c045d03bd34ac14b2b8be7b1e0cacee71bcc4cb57a8ad6331" => :mojave
  end
  
  depends_on "go" => [:build, :test]

  def install
    ENV["GOPATH"] = buildpath
    ENV["GO111MODULE"] = "on"

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
    pos = output.index "CLI version: 1.0.2"
    raise "Version check failed" if pos.nil?

    puts "Success"
  end
end
