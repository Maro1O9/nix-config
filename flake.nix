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
      nixos = lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };  # Pass inputs to modules
        
        modules = [
          ./configuration.nix
          ({ pkgs, ... }: {
            environment.systemPackages = with pkgs; [
              warp-terminal
              neovim
              pkgs.llvmPackages.libcxxClang
              wget
              nixd
              git
              curl
	            gnumake
              zed-editor
              vscode
	            brave
              discord
							telegram-desktop
              postman
              libreoffice-still
              vlc
              go
              rustup
              mold-wrapped
              python314
              racket
              deno

              # domain specific librarys
              # Ui libs 
              udev alsa-lib
              vulkan-loader

              xorg.libX11
              xorg.libXcursor
              xorg.libXi
              xorg.libXrandr # To use the x11 feature

              libxkbcommon
              wayland # To use the wayland feature
              # End Ui Libs 
            ];
          })
        ];
      };
    };
  };
}
