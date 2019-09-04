{ stdenv, fetchurl, autoPatchelfHook, zlib, ncurses5, python27 }:

stdenv.mkDerivation {
  name = "xtensa-esp32-1.22.0-80-g6c4433a-5.2.0";

  src = fetchurl {
    url = "https://dl.espressif.com/dl/xtensa-esp32-elf-linux64-1.22.0-80-g6c4433a-5.2.0.tar.gz";
    sha256 = "0mji8jq1dg198z8bl50i0hs3drdqa446kvf6xpjx9ha63lanrs9z";
  };

  nativeBuildInputs = [ autoPatchelfHook stdenv.cc.cc.lib zlib ncurses5 python27 ];

  installPhase = ''
    mkdir -p $out
    cp -ra * $out
  '';

  dontStrip = true;
}
