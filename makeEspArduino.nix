{ stdenv, fetchurl, unzip }:

stdenv.mkDerivation rec {
  name = "makeEspArduino-${version}";
  version = "4.19.0";

  src = fetchurl {
    url = "https://github.com/plerup/makeEspArduino/archive/${version}.tar.gz";
    sha256 = "1zvrf85pr1iiwgkiq3idzb72m25z37wafna6vvc8khxmxpv3mm2i";
  };

  # nativeBuildInputs = [ ncurses flex bison gperf pkgconfig ];

  # src = fetchFromGitHub {
  #   owner = "esp8266";
  #   repo = "Arduino";
  #   rev = "";
  #   sha256 = "";
  # };

  # buildPhase = ''
  #   # Compile conf-idf and mconf-idf
  #   cd tools/kconfig
  #   make
  #   cd ../..
  # '';

  installPhase = ''
    mkdir -p $out
    cp -ra * $out

  '';

  # dontStrip = true;
}
