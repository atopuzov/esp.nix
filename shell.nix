{ nixpkgs ? <nixpkgs>
}:
let
  pkgs = import nixpkgs {};
  esp8266_rtos_sdk = pkgs.callPackage ./esp8266-rtos-sdk.nix {};
  esp8266_arduino = pkgs.callPackage ./esp8266-arduino.nix {};
  xtensa-lx106 =  pkgs.callPackage ./xtensa-lx106.nix {};
  makeEspArduino = pkgs.callPackage ./makeEspArduino.nix {};
in
  pkgs.stdenv.mkDerivation {
    name = "esp8266-shell";
    buildInputs = [
      esp8266_rtos_sdk esp8266_arduino
      xtensa-lx106
      makeEspArduino
      pkgs.python27Packages.pyserial pkgs.python27Packages.cryptography pkgs.python27Packages.future ];
    shellHook = ''
      export LANG=en_US.UTF-8
      export IDF_PATH=${esp8266_rtos_sdk}
      export ESP_ROOT=${esp8266_arduino}
      export COMP_PATH=${xtensa-lx106}
      alias makeesparduino="make -f ${makeEspArduino}/makeEspArduino.mk"
      echo "Welcome!"
    '';
  }
