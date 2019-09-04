{ stdenv, fetchurl, unzip }:

stdenv.mkDerivation rec {
  name = "makeEspArduino-${version}";
  version = "4.19.0";

  src = fetchurl {
    url = "https://github.com/plerup/makeEspArduino/archive/${version}.tar.gz";
    sha256 = "1zvrf85pr1iiwgkiq3idzb72m25z37wafna6vvc8khxmxpv3mm2i";
  };

  # src = fetchFromGitHub {
  #   owner = "plerup";
  #   repo = "makeEspArduino";
  #   rev = "";
  #   sha256 = "";
  # };
  installPhase = ''
    mkdir -p $out
    cp -ra * $out

  '';
}
