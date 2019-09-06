{ stdenv, fetchurl, unzip, ncurses, flex, bison, gperf, pkgconfig }:

stdenv.mkDerivation rec {
  name = "esp-idf-${version}";
  version = "3.3";

  src = fetchurl {
    url = "https://github.com/espressif/esp-idf/releases/download/v${version}/esp-idf-v${version}.zip";
    sha256 = "0chndd0lk3cpc5lnkl3ay0yylj8gcizd94naxbfraipvyrsxm3cx";
  };

  nativeBuildInputs = [ unzip ncurses flex bison gperf pkgconfig ];

  buildPhase = ''
    # Compile conf-idf and mconf-idf
    cd tools/kconfig
    make
    cd ../..
  '';

  installPhase = ''
    mkdir -p $out
    cp -ra * $out
  '';

  dontStrip = true;
}
