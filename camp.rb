class Camp < Formula
  homepage "https://github.com/tegesoft/camp"
  url "https://github.com/drbenmorgan/camp.git", :branch => "cmake-support"
  version "0.8.0"

  option "with-doc", "Build with doxygen documentation"
  option :cxx11

  depends_on "cmake" => :build
  depends_on "doxygen" => :build if build.with? "doc"

  if build.cxx11?
    depends_on "boost" => "c++11"
  else
    depends_on "boost"
  end

  def install
    ENV.cxx11 if build.cxx11?
    system "cmake", ".", *std_cmake_args
    system "make"
    system "make doc" if build.with? "doc"
    system "make", "install"
  end

  test do
    system "false"
  end
end

