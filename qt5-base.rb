require "formula"

class Qt5Base < Formula
  homepage "http://qt-project.org/"
  url "http://download.qt.io/official_releases/qt/5.4/5.4.1/submodules/qtbase-opensource-src-5.4.1.tar.gz"
  sha1 "1a908de9b0d971291c25ce010518efbb61199516"

  keg_only "Qt5 conflicts with the more widely used Qt4"

  depends_on :xcode => :build
  depends_on "pkg-config" => :build

  def install
    args = ["-prefix", prefix,
            "-opensource",
            "-confirm-license",
            "-release",
            "-nomake", "tests",
            "-nomake", "examples"]

    system "./configure", *args
    # Cannot parellize build os OSX
    system "make"
    ENV.j1
    system "make", "install"
  end

  def caveats; <<-EOS.undent
    We agreed to the Qt opensource license for you.
    If this is unacceptable you should uninstall.
    EOS
  end
end
