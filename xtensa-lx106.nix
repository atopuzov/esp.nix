{ stdenv, fetchurl, autoPatchelfHook, zlib, ncurses5, python27 }:

stdenv.mkDerivation {
  name = "xtensa-lx106-1.22.0-92-g8facf4c-5.2.0";

  src = fetchurl {
    url = "https://dl.espressif.com/dl/xtensa-lx106-elf-linux64-1.22.0-92-g8facf4c-5.2.0.tar.gz";
    sha256 = "0cz69nf5gz22my71zp95wgbhnnwqx5dlfws703wvxrbx0rmyr47x";
  };

  nativeBuildInputs = [ autoPatchelfHook stdenv.cc.cc.lib zlib ncurses5 python27 ];

  installPhase = ''
    mkdir -p $out
    cp -ra * $out
  '';

  dontStrip = true;
}
