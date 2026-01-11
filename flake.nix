{
  description = "NixOS System Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    systems.url = "github:nix-systems/default-linux";
    hardware.url = "github:nixos/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence = {
      # url = "github:nix-community/impermanence";
      url = "github:misterio77/impermanence";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-minecraft = {
      url = "github:Infinidoge/nix-minecraft";
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

    overlays = import ./overlays {inherit inputs outputs;};
    templates = import ./templates;

    packages = forEachSystem (pkgs: import ./pkgs {inherit pkgs;});
    devShells = forEachSystem (pkgs: import ./shell.nix {inherit pkgs;});
    formatter = forEachSystem (pkgs: pkgs.alejandra);

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
      office = lib.nixosSystem {
        modules = [./hosts/office];
        specialArgs = {inherit inputs outputs;};
      };
    };

    # Standalone HM only
    # homeConfigurations = {
    #   "averagebit@zulu" = lib.homeManagerConfiguration {
    #     modules = [./home/averagebit/zulu];
    #     pkgs = pkgsFor.x86_64-linux;
    #     extraSpecialArgs = {
    #       inherit inputs outputs;
    #     };
    #   };
    # };
  };
}
