{ stdenv, fetchurl, unzip }:

stdenv.mkDerivation rec {
  name = "esp8266-arduino-${version}";
  version = "2.5.2";

  src = fetchurl {
    url = "https://github.com/esp8266/Arduino/releases/download/${version}/esp8266-${version}.zip";
    sha256 = "1ch0nyz6lnm49icb528j547c6xq1fcpyar6b5ai4wsw3wfkgz3dy";
  };

  nativeBuildInputs = [ unzip ];

  # src = fetchFromGitHub {
  #   owner = "esp8266";
  #   repo = "Arduino";
  #   rev = "";
  #   sha256 = "";
  # };

  installPhase = ''
    mkdir -p $out
    cp -ra * $out

  '';

  dontStrip = true;
}
