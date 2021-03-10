require "language/node"

class NooBaaCore < Formula
  desc "NooBaa-core is a standalone program that packages multiple core commands"
  homepage "https://github.com/noobaa/noobaa-core"
  url "https://github.com/noobaa/noobaa-core.git",
      :tag      => "v5.6.0",
      :revision => "8b9ad5ebe346afe4f46ba4d72526c435cefab7ac"
  head "https://github.com/noobaa/noobaa-core.git"

  depends_on "node"
  depends_on "python" => :build

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    system "npm", "run", "build:native", *Language::Node.std_npm_install_args(libexec)
    system "npm", "run", "build:core", *Language::Node.std_npm_install_args(libexec)
    bin.install "build/noobaa-core-macos" => "noobaa-core"
  end

  test do
    output = `#{bin}/noobaa-core 2>&1`
    pos = output.index "\"noobaa-core\" is a program that packages multiple core commands"
    raise "Version check failed" if pos.nil?
    puts "Success"
  end
end
