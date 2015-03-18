class Qt4 < Formula
  homepage "http://www.qt.io"
  url "https://download.qt.io/official_releases/qt/4.8/4.8.6/qt-everywhere-opensource-src-4.8.6.tar.gz"
  mirror "http://qtmirror.ics.com/pub/qtproject/official_releases/qt/4.8/4.8.6/qt-everywhere-opensource-src-4.8.6.tar.gz"
  sha1 "ddf9c20ca8309a116e0466c42984238009525da6"

  # This patch should be able to be removed with the next stable Qt4 release.
  patch do
    url "https://raw.githubusercontent.com/DomT4/scripts/440e3cafde5bf6ec6f50cd28fa5bf89c280f1b53/Homebrew_Resources/Qt/qt4patch.diff"
    sha1 "57246a33460246118a1fab7460c79f2077d3a929"
  end

  option :cxx11

  def install
    args = [ "-prefix", prefix,
             "-plugindir", "#{lib}/qt4/plugins",
             "-importdir", "#{lib}/qt4/imports",
             "-datadir", "#{share}/qt4",
             "-translationdir", "#{share}/qt4/translations",
             "-opensource",
             "-confirm-license",
             "-fast",
             "-release",
             "-nomake", "demos",
             "-nomake", "examples",
             "-nomake", "tools",
             "-system-zlib",
             "-system-sqlite",
             "-no-qt3support", 
             "-no-multimedia", 
             "-no-audio-backend",
             "-no-phonon", 
             "-no-webkit",
             "-no-javascript-jit"
             ]

   if ENV.compiler == :clang
     args << "-platform"

     if MacOS.version >= :mavericks
       args << "unsupported/macx-clang-libc++"
     else
       args << "unsupported/macx-clang"
     end
   end

   # Database plugins - none for now. Enable as/when required
   # E.g., might want psql for AMI
   args << "-no-sql-mysql"
   args << "-no-sql-odbc"
   args << "-no-sql-psql"

   # QtScript (specifically, JavaScriptCore) cannot be built in C++11
   # mode. Add extra flags to be removed when using GNU compiler.
   # May also need to do this for Clang, but libc++ ABI more reliable?
   inreplace "src/script/script.pro", "-std=c++0x", "-std=c++0x -std=c++11 -std=gnu++11"

   # Enabling cxx11 in Qt4 *should* just be a case of adding required flags
   # but we can't do this through homebrew because homebrew
   if build.cxx11?
     ENV.append 'CXXFLAGS', "-std=c++11"
   end

   # Configure...
   system "./configure", *args
   system "make"
   ENV.j1
   system "make", "install"
  end

  test do
    system "#{bin}/qmake", "-project"
  end

  def caveats; <<-EOS.undent
    We agreed to the Qt opensource license for you.
    If this is unacceptable you should uninstall.
    EOS
  end
end
