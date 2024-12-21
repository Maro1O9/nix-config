{
  description = "main flake";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-24.11";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
  let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
  in {
    nixosConfigurations = {
      MrMaro = lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };  # Pass inputs to modules
        modules = [
          ./configuration.nix 
          ({ pkgs, ... }: {
            environment.systemPackages = with pkgs; [
              neovim
              (nerdfonts.override { fonts = [ "FiraCode" "CascadiaCode" ]; })
              pkgs.llvmPackages.libcxxClang
              wget
              git
              curl
	            gnumake
              zed-editor 
              vscode
	            brave
              libreoffice-still-unwrapped
              vlc
              go
              rustup
              mold-wrapped

            ];
          })
        ];
      };
    };
  };
}
