class CadfaelToolchain < Formula
  url File.dirname(__FILE__), :using => :git
  version "1.0.0"

  if OS.linux?
    depends_on "pkg-config"
    depends_on "gcc" => "without-fortran"
    depends_on "patchelf"
    depends_on "binutils"
    # Need an explicit python dependency - ':python' will ger built
    # before gcc, and ideally we want it built with the same compiler.
    depends_on "python"
  end

  depends_on "cmake"

  def install
    bin.mkdir
    system "touch", "#{bin}/cadfael-toolchain-installed"
  end
end

