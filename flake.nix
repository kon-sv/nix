{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-xr.url = "github:nix-community/nixpkgs-xr";

    # agenix.url = "github:ryantm/agenix";

    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.05";
      # url = "./nixvim";
      # If using a stable channel you can use `url = "github:nix-community/nixvim/nixos-<version>"`
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      # If using a stable channel you can use `url = "github:nix-community/nixvim/nixos-<version>"`
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    nixpkgs-xr,
    home-manager,
    nixvim,
    hyprland,
  } @ inputs: let
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    homeLib = home-manager.lib;
    pkgs = nixpkgs.legacyPackages.${system};
    variables = {
      onGui = true;
      user = "konsv";
      username = "konsv";

    }; # nixpkgs.lib.importJSON ./secrets/variables.json;

    pkgsUnstable = import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };

    specialArgs = nothing: {
      inherit inputs;
      vars = variables;
      pkgs-unstable = pkgsUnstable;
    };

    nixosConfig = {
      configPath,
      useUnstable ? false,
      useWorkVars ? false,
      gpuAcceleration ? false,
      remote ? false,
      extraModules ? [],
    }: let
      nixpkgsSrc =
        if useUnstable
        then nixpkgs-unstable
        else nixpkgs;
    in
      nixpkgsSrc.lib.nixosSystem {
        modules =
          [
            configPath
          ]
          ++ extraModules;
        specialArgs = specialArgs useWorkVars // {inherit gpuAcceleration remote;};
      };

    homeConfig = {
      configPath,
      extraModules ? [],
      onGui ? false,
    }:
      homeLib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit onGui;
          vars = variables.home;
        };
        modules =
          [
            configPath
          ]
          ++ extraModules;
      };
  in {
    nixosConfigurations = {
      ayame = nixosConfig {
        configPath = ./hosts/ayame/configuration.nix;
        extraModules = [];
        gpuAcceleration = true;
      };

    };

    homeConfigurations = {
      konsv = homeConfig {
        configPath = ./home-manager/konsv/home.nix;
        onGui = true;  # variables.home.onGui;
        extraModules = [
          nixvim.homeModules.nixvim
        ];
      };
    };
  };
}
