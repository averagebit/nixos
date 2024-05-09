{inputs, ...}: let
  addPatches = pkg: patches:
    pkg.overrideAttrs (oldAttrs: {
      patches = (oldAttrs.patches or []) ++ patches;
    });
in {
  # For every flake input, aliases 'pkgs.inputs.${flake}' to
  # 'inputs.${flake}.packages.${pkgs.system}' or
  # 'inputs.${flake}.legacyPackages.${pkgs.system}'
  flake-inputs = final: _: {
    inputs = builtins.mapAttrs (_: flake: let
      legacyPackages = (flake.legacyPackages or {}).${final.system} or {};
      packages = (flake.packages or {}).${final.system} or {};
    in
      if legacyPackages != {}
      then legacyPackages
      else packages)
    inputs;
  };

  # Adds pkgs.stable == inputs.nixpkgs-stable.legacyPackages.${pkgs.system}
  stable = final: _: {
    stable = inputs.nixpkgs-stable.legacyPackages.${final.system};
  };

  additions = final: prev:
    import ../pkgs {pkgs = final;}
    // {
      formats = prev.formats // import ../pkgs/formats {pkgs = final;};
    };

  modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });

    # ollama = addPatches prev.ollama [./ollama.patch];

    # ollama = prev.ollama.overrideAttrs (oldAttrs: rec {
    #   version = "0.1.31";
    #   src = final.fetchFromGitHub {
    #     owner = "ollama";
    #     repo = "ollama";
    #     rev = "v${version}";
    #     hash = "sha256-Ip1zrhgGpeYo2zsN206/x+tcG/bmPJAq4zGatqsucaw=";
    #     fetchSubmodules = true;
    #   };
    #   vendorHash = "sha256-Lj7CBvS51RqF63c01cOCgY7BCQeCKGu794qzb/S80C0=";
    #   patches = (oldAttrs.patches or []) ++ [./ollama.patch];
    # });
  };
}
