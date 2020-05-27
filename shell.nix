{ nixpkgs ? import ./nixpkgs.nix }:
let
  pkgs = import nixpkgs {};
  esp8266_rtos_sdk = pkgs.callPackage ./esp8266-rtos-sdk.nix {};
  esp8266_arduino = pkgs.callPackage ./esp8266-arduino.nix {};
  xtensa-lx106 =  pkgs.callPackage ./xtensa-lx106.nix {};
  xtensa-lx106-old = xtensa-lx106.overrideAttrs (oldAttrs: rec {
    version = "1.22.0-88-gde0bdc1-4.8.5";
    src = pkgs.fetchurl {
      url = "https://dl.espressif.com/dl/xtensa-lx106-elf-linux64-1.22.0-88-gde0bdc1-4.8.5.tar.gz";
      sha256 = "0ylsh9xx3cypybr1066p7d93i1ki0vvncb5vhcdvcjb35vl6lj08";
    };
  });
  xtensa-lx106-arduino = pkgs.callPackage ./xtensa-lx106-arduino.nix {};
  makeEspArduino = pkgs.callPackage ./makeEspArduino.nix {};
  esp-idf-lib = pkgs.callPackage ./esp-idf-lib.nix {};
  esp-idf = pkgs.callPackage ./esp-idf.nix {};
  xtensa-esp32 = pkgs.callPackage ./xtensa-esp32.nix {};
  xtensa-esp32-old = xtensa-esp32.overrideAttrs (oldAttrs: rec {
   src = pkgs.fetchurl {
     url = "https://dl.espressif.com/dl/xtensa-esp32-elf-linux64-1.22.0-80-g6c4433a-5.2.0.tar.gz";
     sha256 = "0mji8jq1dg198z8bl50i0hs3drdqa446kvf6xpjx9ha63lanrs9z";
   };
  });
in
  pkgs.stdenv.mkDerivation {
    name = "esp8266-shell";
    buildInputs = [
      esp8266_rtos_sdk esp8266_arduino
      esp-idf-lib
      xtensa-lx106
      xtensa-esp32
      makeEspArduino
    ] ++ (with pkgs.python27Packages; [ pyserial cryptography future pyparsing]);

    shellHook = ''
      export LANG=en_US.UTF-8
      export IDF_PATH=${esp8266_rtos_sdk}
      export ESP_ROOT=${esp8266_arduino}
      export COMP_PATH=${xtensa-lx106-arduino}
      export PY_PATH=${pkgs.python27}/bin
      export ESP_IDF_LIB=${esp-idf-lib}
      alias makeesparduino="make -f ${makeEspArduino}/makeEspArduino.mk"
      echo "Welcome!"
      echo "ESP8266 IDF is at ${esp8266_rtos_sdk}"
      echo "export IDF_PATH=${esp8266_rtos_sdk}"

      echo "ESP32 IDF is at ${esp-idf}"
      echo "export IDF_PATH=${esp-idf}"
    '';
  }
