{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  name = "esp-idf-lib";

  src = fetchFromGitHub {
    owner = "UncleRus";
    repo = "esp-idf-lib";
    rev = "90392ccc217265ce3d7d7827e05f1be9c5f6a4ac";
    sha256 = "1g5a6wqgqsnmy5ydycn3mbcllxqzcjzn1339a5a4qaivdrvhy9c9";
  };

  installPhase = ''
    mkdir -p $out
    cp -ra * $out

  '';

  dontStrip = true;
}
