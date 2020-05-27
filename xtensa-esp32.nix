{ stdenv, fetchurl, autoPatchelfHook, zlib, ncurses5, python27 }:

# https://github.com/espressif/esp-idf/blob/master/tools/tools.json

stdenv.mkDerivation rec {
  pname = "xtensa-esp32";
  version = "gcc8_2_0-esp-2020r1";
  platform = "linux-amd64"; # _TODO_ macos support

  src = fetchurl {
    url = "https://dl.espressif.com/dl/${pname}-elf-${version}-${platform}.tar.gz";
    sha256 = "b65ae41a675c866f5e11e3c452fc4b9cee3f39038d88435faa45308f50388c54";
  };

  nativeBuildInputs = [ autoPatchelfHook stdenv.cc.cc.lib zlib ncurses5 python27 ];

  installPhase = ''
    mkdir -p $out
    cp -ra * $out
  '';

  dontStrip = true;
}
