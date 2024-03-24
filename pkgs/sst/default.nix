{
  pkgs,
  lib,
  fetchFromGitHub,
  buildGoModule,
}:
buildGoModule rec {
  pname = "sst";
  version = "0.0.194";

  src = fetchFromGitHub {
    owner = "sst";
    repo = "ion";
    rev = "v${version}";
    hash = "sha256-TlEtS50RYHzJZH0zGryh/W/PkJ6da6ah+RbsgLOUtgE=";
  };

  vendorHash = "sha256-IXnYxKnQXKCpQvfxUq2kRDqYG1+l0svOYFPvvMdECzk=";

  ldflags = ["-s" "-w" "-X main.version=${version}"];

  CGO_ENABLED = 0;

  meta = with lib; {
    homepage = "https://github.com/sst/ion";
    description = "Ion is a new engine for deploying SST apps. It uses Pulumi and Terraform, as opposed to CDK and CloudFormation..";
    mainProgram = "sst";
    maintainers = with maintainers; [averagebit];
    platforms = platforms.unix;
    sourceProvenance = with sourceTypes; [fromSource];
    # license = licenses.mit;
  };
}
