class Cadfael < Formula
  url File.dirname(__FILE__), :using => :git
  version "1.0.0"

  depends_on "drbenmorgan/supernemo/cadfael-toolchain"

  depends_on "boost" => ["with-icu4c", "without-single", "without-static"]
  depends_on "boost-python"
  depends_on "drbenmorgan/supernemo/camp" => "with-doc"
  depends_on "drbenmorgan/supernemo/clhep"
  depends_on "drbenmorgan/supernemo/geant4" => "with-gdml"
  depends_on "drbenmorgan/supernemo/xerces-c"
  depends_on "drbenmorgan/supernemo/root" => ["with-python"]

  def install
    bin.mkdir
    system "touch", "#{bin}/cadfael-installed"
  end
end

