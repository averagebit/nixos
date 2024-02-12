{pkgs}:
pkgs.buildGoModule {
  pname = "foo";
  version = "0.1.0";

  src = ./.;

  vendorHash = null;
}
