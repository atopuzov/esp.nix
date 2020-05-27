{ stdenv, fetchurl, autoPatchelfHook, zlib, ncurses5, python27 }:

stdenv.mkDerivation rec {
  pname = "xtensa-lx106";
  version = "1.22.0-100-ge567ec7-5.2.0";
  platform = "linux64"; # _TODO_ macos support

  src = fetchurl {
    url = "https://dl.espressif.com/dl/${pname}-elf-${platform}-${version}.tar.gz";
    sha256 = "1574p170cpd46pz5mpi22jsfqrj5bd7xys1gj5fzihjr6y2h4skh";
  };

  nativeBuildInputs = [ autoPatchelfHook stdenv.cc.cc.lib zlib ncurses5 python27 ];

  installPhase = ''
    mkdir -p $out
    cp -ra * $out
  '';

  dontStrip = true;
}
