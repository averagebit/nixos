{inputs, ...}: {
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

  # additions = final: prev: import ../pkgs {pkgs = final;};
  additions = final: prev:
    import ../pkgs {pkgs = final;}
    // {
      formats = prev.formats // import ../pkgs/formats {pkgs = final;};
    };

  modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });
  };
}
