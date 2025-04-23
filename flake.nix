{
  description = "CUPS drivers for Xprinter 58 & 80 thermal printers";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # Or your preferred channel
    #flake-utils.url = "github:numtide/flake-utils";

    # Input for your driver repository
    xprinter-pos = {
      url = "github:jujodeve/xprinter-pos"; # <-- IMPORTANT: Replace with your repo details
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #        stdenv,
    #  cups,
    #  lib,
    #  glibc,
    #  fetchFromGitLab,
    #  gcc-unwrapped,
    #  autoPatchelfHook,
  };

  outputs =
    {
      #self,
      nixpkgs,
      #flake-utils,
      #xprinter-pos,
      #pkgs,
      #lib
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      xprinter-pos = pkgs.stdenv.mkDerivation {

        name = "cups-xprinterpos";
        version = "1.0";
        system = "x86_64-linux";

        nativeBuildInputs = [
          pkgs.autoPatchelfHook
        ];

        buildInputs = with pkgs; [
          cups
          glibc
          gcc-unwrapped
        ];

        installPhase = ''
          install -d -m 777 $out/share/cups/model/xprinterpos/
          install -m 644 ppd/*.ppd $out/share/cups/model/xprinterpos/
          install -m 755 -D filter/x64/rastertosnailep-pos $out/lib/cups/filter/rastertosnailep-pos
        '';

       #  meta = with lib; {
       #    description = "CUPS filter for XPrinter POS thermal printers";
       #    homepage = "https://github.com/jotix/xprinterpos";
       #    platforms = platforms.linux;
       #    maintainers = with maintainers; [ jotix ];
       #    license = licenses.bsd2;
       #  };
      };
    };

}
