{ nixpkgs ? <nixpkgs>
}:
let
  pkgs = import nixpkgs {};
  esp8266_rtos_sdk = pkgs.callPackage ./esp8266-rtos-sdk.nix  {};
  xtensa-lx106 =  pkgs.callPackage ./xtensa-lx106.nix {};
in
  pkgs.stdenv.mkDerivation {
    name = "esp8266-shell";
    buildInputs = [ esp8266_rtos_sdk xtensa-lx106 pkgs.python27Packages.pyserial pkgs.python27Packages.cryptography ];
    shellHook = ''
      export LANG=en_US.UTF-8
      export IDF_PATH=${esp8266_rtos_sdk}
      echo "Welcome!"
    '';
  }
