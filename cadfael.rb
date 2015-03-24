class Cadfael < Formula
  url File.dirname(__FILE__), :using => :git
  version "1.0.0"

  option :cxx11

  depends_on "drbenmorgan/supernemo/cadfael-toolchain"

  if build.cxx11?
    depends_on "boost" => ["c++11", "with-icu4c", "without-single", "without-static"]
    #depends_on "boost-python"
    depends_on "drbenmorgan/supernemo/clhep" => "c++11"
    depends_on "drbenmorgan/supernemo/xerces-c" => "c++11"
    depends_on "drbenmorgan/supernemo/geant4" => "with-xerces-c"
    depends_on "drbenmorgan/supernemo/camp" => ["c++11", "with-doxygen"]
    depends_on "drbenmorgan/supernemo/root" => ["c++11", "with-python"]
  else
    depends_on "boost" => ["with-icu4c", "without-single", "without-static"]
    #depends_on "boost-python"
    depends_on "drbenmorgan/supernemo/clhep"
    depends_on "drbenmorgan/supernemo/xerces-c"
    depends_on "drbenmorgan/supernemo/geant4" => "with-xerces-c"
    depends_on "drbenmorgan/supernemo/camp" => "with-doxygen"
    depends_on "drbenmorgan/supernemo/root" => "with-python"
  end

  def install
    bin.mkdir
    system "touch", "#{bin}/cadfael-installed"
  end
end

