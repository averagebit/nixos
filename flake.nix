{
  description = "NixOS System Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";
    systems.url = "github:nix-systems/default-linux";
    hardware.url = "github:nixos/nixos-hardware";
    impermanence.url = "github:nix-community/impermanence";

    nix = {
      url = "github:nixos/nix/2.22-maintenance";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs";
    };

    hyprwm-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    systems,
    ...
  } @ inputs: let
    inherit (self) outputs;
    lib = nixpkgs.lib // home-manager.lib;
    forEachSystem = f: lib.genAttrs (import systems) (system: f pkgsFor.${system});
    pkgsFor = lib.genAttrs (import systems) (
      system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        }
    );
  in {
    inherit lib;
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;

    packages = forEachSystem (pkgs: import ./pkgs {inherit pkgs;});
    devShells = forEachSystem (pkgs: import ./shell.nix {inherit pkgs;});
    overlays = import ./overlays {inherit inputs outputs;};
    formatter = forEachSystem (pkgs: pkgs.alejandra);
    templates = import ./templates;

    nixosConfigurations = {
      anton = lib.nixosSystem {
        modules = [./hosts/anton];
        specialArgs = {inherit inputs outputs;};
      };
      wopr = lib.nixosSystem {
        modules = [./hosts/wopr];
        specialArgs = {inherit inputs outputs;};
      };
      zulu = lib.nixosSystem {
        modules = [./hosts/zulu];
        specialArgs = {inherit inputs outputs;};
      };
    };

    homeConfigurations = {
      "averagebit@anton" = lib.homeManagerConfiguration {
        modules = [./home/averagebit/anton];
        extraSpecialArgs = {inherit inputs outputs;};
        pkgs = pkgsFor.x86_64-linux;
      };
      "averagebit@wopr" = lib.homeManagerConfiguration {
        modules = [./home/averagebit/wopr];
        extraSpecialArgs = {inherit inputs outputs;};
        pkgs = pkgsFor.x86_64-linux;
      };
      "averagebit@zulu" = lib.homeManagerConfiguration {
        modules = [./home/averagebit/zulu];
        extraSpecialArgs = {inherit inputs outputs;};
        pkgs = pkgsFor.x86_64-linux;
      };
    };
  };
}
