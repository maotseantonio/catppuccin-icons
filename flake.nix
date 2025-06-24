
{
  description = "Catppuccin Icon Theme Flake";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };

    catppuccinIconsPkg = pkgs.stdenv.mkDerivation {
      pname = "catppuccin-icons";
      version = "1.0";
      src = ./Catppuccin-SE;
      installPhase = ''
        mkdir -p $out/share/icons
        cp -r . $out/share/icons/Catppuccin-SE
      '';

      meta = with pkgs.lib; {
        description = "Catppuccin icon theme";
        homepage = "https://github.com/catppuccin";
        license = licenses.mit;
        platforms = platforms.linux;
      };
    };
  in {
    packages.${system} = {
      catppuccin-icons = catppuccinIconsPkg;
    };

    defaultPackage.${system} = catppuccinIconsPkg;
  };
}

