{buildNpmPackage}:
buildNpmPackage {
  pname = "foo";
  version = "0.0.1";

  src = ./.;

  npmDepsHash = "sha256-beVAT0peUuijkoIiZH+SfmuO7BwyYNsgLykrsEO1CVw=";
}
