{
  description = "CUPS drivers for Xprinter 58 & 80 thermal printers";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # Or your preferred channel
  };

  outputs = { self, nixpkgs }:
  let
      pkgName = "xprinterpos";
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
  in 
  {
    packages.${system}.default = pkgs.stdenv.mkDerivation {

        name = pkgName;
        version = "1.0";
        system = "x86_64-linux";
        src = self;

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
      };

      # Overlay
      overlays.default = final: prev: {
        ${pkgName} = self.packages.${prev.system}.default;
      };
    };
}
