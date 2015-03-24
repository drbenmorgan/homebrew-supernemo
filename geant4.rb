class Geant4 < Formula
  homepage "http://geant4.cern.ch"
  url "http://geant4.cern.ch/support/source/geant4.9.6.p04.tar.gz"
  version "9.6.4"
  sha256 "997220a5386a43ac8f533fc7d5a8360aa1fd6338244d17deeaa583fb3a0f39fd"

  option "with-xerces-c", "Build with GDML support"

  depends_on "cmake" => :build
  depends_on :x11 if OS.linux?
  depends_on "drbenmorgan/supernemo/clhep"
  depends_on "drbenmorgan/supernemo/xerces-c" => :optional


  def install
    mkdir 'geant4-build' do
      args = std_cmake_args
      args << "-DCMAKE_INSTALL_LIBDIR=lib"
      args << "-DCMAKE_BUILD_WITH_INSTALL_RPATH=ON"
      args << "-DGEANT4_INSTALL_DATA=ON"
      args << "-DGEANT4_USE_OPENGL_X11=ON" if OS.linux?
      args << "-DGEANT4_USE_RAYTRACER_X11=ON" if OS.linux?
      args << "-DGEANT4_USE_SYSTEM_CLHEP=ON"
      args << "-DGEANT4_USE_SYSTEM_EXPAT=ON"
      #args << "-DGEANT4_USE_SYSTEM_ZLIB=ON"

      args << "-DGEANT4_USE_GDML=ON" if build.with? "xerces-c"

      system "cmake", "../", *args
      system "make", "install"
    end
  end

  test do
    system "false"
  end
end
