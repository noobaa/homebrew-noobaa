class Noobaa < Formula
  desc "CLI for managing NooBaa S3 service on Kubernetes/Openshift"
  homepage "https://github.com/noobaa/noobaa-operator"
  url "https://github.com/noobaa/noobaa-operator.git",
      :tag      => "v1.1.1",
      :revision => "9d7746b0d73baf39618de5fdc3465619cc2ebebe"
  head "https://github.com/noobaa/noobaa-operator.git"

  bottle do
    root_url "https://github.com/noobaa/homebrew-noobaa/releases/download/v1.1.1"
    cellar :any_skip_relocation
    sha256 "e948e81a6d52c03b1fddde7e82d2cede89d702d8b3953a19b5335d4d352607bc" => :mojave
  end
  
  depends_on "go" => [:build, :test]

  def install
    ENV["GOPATH"] = buildpath
    ENV["GO111MODULE"] = "on"

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
    pos = output.index "CLI version: 1.1.1"
    raise "Version check failed" if pos.nil?

    puts "Success"
  end
end
