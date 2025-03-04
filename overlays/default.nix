{
  inputs,
  outputs,
  ...
}: let
  addPatches = pkg: patches:
    pkg.overrideAttrs (oldAttrs: {
      patches = (oldAttrs.patches or []) ++ patches;
    });
in {
  # For every flake input, aliases 'pkgs.inputs.${flake}' to
  # 'inputs.${flake}.packages.${pkgs.system}' or
  # 'inputs.${flake}.legacyPackages.${pkgs.system}'
  flake-inputs = final: _: {
    inputs =
      builtins.mapAttrs (
        _: flake: let
          legacyPackages = (flake.legacyPackages or {}).${final.system} or {};
          packages = (flake.packages or {}).${final.system} or {};
        in
          if legacyPackages != {}
          then legacyPackages
          else packages
      )
      inputs;
  };

  # Adds pkgs.stable == inputs.nixpkgs-stable.legacyPackages.${pkgs.system}
  stable = final: _: {
    stable = inputs.nixpkgs-stable.legacyPackages.${final.system};
  };

  # Add custom packages
  additions = final: prev:
    import ../pkgs {pkgs = final;}
    // {
      formats = prev.formats // import ../pkgs/formats {pkgs = final;};
    };

  # Modify existing packages
  modifications = final: prev: let
    wine =
      import
      (fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/da466ad.tar.gz";
        sha256 = "04wc7l07f34aml0f75479rlgj85b7n7wy2mky1j8xyhadc2xjhv5";
      }) {
        system = final.system;
        config = {};
      };
  in {
    # example = addPatches prev.example [./example.patch];
    #
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });

    # https://github.com/NixOS/nixpkgs/issues/375460
    wineWowPackages =
      prev.wineWowPackages
      // {
        staging = wine.wineWowPackages.waylandFull;
        stagingFull = wine.wineWowPackages.waylandFull;
      };
    yabridge = prev.yabridge.override {
      wine = wine.wineWowPackages.waylandFull;
    };
    yabridgectl = prev.yabridgectl.override {
      wine = wine.wineWowPackages.waylandFull;
    };
  };
}
