{ nixpkgs ? <nixpkgs>
}:
let
  pkgs = import nixpkgs {};
  esp8266_rtos_sdk = pkgs.callPackage ./esp8266-rtos-sdk.nix {};
  esp8266_arduino = pkgs.callPackage ./esp8266-arduino.nix {};
  xtensa-lx106 =  pkgs.callPackage ./xtensa-lx106.nix {};
  xtensa-lx106-old = xtensa-lx106.overrideAttrs (oldAttrs: rec {
    name = "xtensa-lx106-1.22.0-88-gde0bdc1-4.8.5";
    src = pkgs.fetchurl {
      url = "https://dl.espressif.com/dl/xtensa-lx106-elf-linux64-1.22.0-88-gde0bdc1-4.8.5.tar.gz";
      sha256 = "0ylsh9xx3cypybr1066p7d93i1ki0vvncb5vhcdvcjb35vl6lj08";
    };
  });
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
      export COMP_PATH=${xtensa-lx106-old}
      alias makeesparduino="make -f ${makeEspArduino}/makeEspArduino.mk"
      echo "Welcome!"
    '';
  }
