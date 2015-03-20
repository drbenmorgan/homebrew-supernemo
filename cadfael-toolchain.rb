class CadfaelToolchain < Formula
  url File.dirname(__FILE__), :using => :git
  version "1.0.0"

  if OS.linux?
    depends_on "pkg-config"
    depends_on "gcc"
    depends_on "patchelf"
    depends_on "binutils"
    depends_on "python"
  end

  depends_on "cmake"

  def install
    bin.mkdir
    system "touch", "#{bin}/cadfael-toolchain-installed"
  end
end

