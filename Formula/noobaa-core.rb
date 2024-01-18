require "language/node"

class NoobaaCore < Formula
  desc "noobaa-core is a standalone program that packages multiple core commands"
  homepage "https://github.com/noobaa/noobaa-core"
  url "https://github.com/noobaa/noobaa-core.git",
    :branch => "master"
  version "master"
  head "https://github.com/noobaa/noobaa-core.git"

  depends_on "node@20"
  depends_on "python" => :build
  depends_on "yasm"

  def install
    system "npm", "install", *Language::Node.local_npm_install_args
    system "npm", "run", "build"
    system "npm", "run", "pkg"
    bin.install "build/noobaa-core"
  end

  test do
    output = `#{bin}/noobaa-core 2>&1`
    pos = output.index "\"noobaa-core\" is a program that packages multiple core commands"
    raise "Version check failed" if pos.nil?
    puts "Success"
  end
end
