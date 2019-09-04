{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  name = "esp8266-rtos-sdk-${version}";
  version = "3.2";

  src = fetchurl {
    url = "https://github.com/espressif/ESP8266_RTOS_SDK/archive/v${version}.tar.gz";
    sha256 = "0zx1p7kar1mpnkxy6m7w42v5pdmfvy17g3k4xscrj0i1gma8piaz";
  };

  # src = fetchFromGitHub {
  #   owner = "espressif";
  #   repo = "ESP8266_RTOS_SDK";
  #   rev = "";
  #   sha256 = "";
  # };

  installPhase = ''
    mkdir -p $out
    cp -ra * $out

  '';

  dontStrip = true;
}
