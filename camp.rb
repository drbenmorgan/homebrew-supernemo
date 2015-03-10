class Camp < Formula
  homepage "https://github.com/tegesoft/camp"
  url "https://github.com/tegesoft/camp.git", :tag => "0.8.0"
  version "0.8.0"

  patch :DATA

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
    system "make", "install"
  end

  test do
    system "false"
  end
end

__END__
diff --git a/CMakeLists.txt b/CMakeLists.txt
index f11ce20..65f73d8 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -205,7 +205,7 @@ install(TARGETS camp
     ARCHIVE DESTINATION lib COMPONENT devel
 )
 
-install(FILES README.txt COPYING.txt LICENSE.LGPL3.txt
+install(FILES README.txt COPYING.txt
     DESTINATION ${INSTALL_MISC_DIR}
 )
