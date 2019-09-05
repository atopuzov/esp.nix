{ stdenv, fetchurl, autoPatchelfHook }:

stdenv.mkDerivation {
    name = "xtensa-lx106-2.5.0-4";
    src = fetchurl {
      url = "https://github.com/earlephilhower/esp-quick-toolchain/releases/download/2.5.0-4/x86_64-linux-gnu.xtensa-lx106-elf-b40a506.1563313032.tar.gz";
      sha256 = "1000f022rxzqb09h21q5cjkh8qn4dbsf4cfjjxhg7272kfj4vq4h";
    };

  nativeBuildInputs = [ autoPatchelfHook ];

  installPhase = ''
    mkdir -p $out
    cp -ra * $out
  '';

  dontStrip = true;
}
