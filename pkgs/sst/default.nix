{
  pkgs,
  lib,
  fetchFromGitHub,
  buildGoModule,
}:
buildGoModule rec {
  pname = "sst";
  version = "0.0.245";

  src = fetchFromGitHub {
    owner = "sst";
    repo = "ion";
    rev = "v${version}";
    hash = "sha256-isPXTv2MXWBI3YrDPxCzLliTgXjZxrjTiSRacLxgKOQ=";
  };

  vendorHash = "sha256-F/6VawWgBjpNcjRT2rbf/01Dc5Xzd6KrUD3kFPVUVCQ=";

  ldflags = ["-s" "-w" "-X main.version=${version}"];

  CGO_ENABLED = 0;

  meta = with lib; {
    homepage = "https://github.com/sst/ion";
    description = "Ion is a new engine for deploying SST apps. It uses Pulumi and Terraform, as opposed to CDK and CloudFormation..";
    mainProgram = "sst";
    maintainers = with maintainers; [averagebit];
    platforms = platforms.unix;
    sourceProvenance = with sourceTypes; [fromSource];
    license = licenses.mit;
  };
}
