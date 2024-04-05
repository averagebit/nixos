{pkgs}:
pkgs.buildGoModule rec {
  pname = "foo";
  version = "0.1.0";

  src = ./.;

  ldflags = ["-s" "-w" "-X main.version=${version}"];

  CGO_ENABLED = 0;

  vendorHash = null;

  meta = with lib; {
    homepage = "";
    description = "foo tool description";
    mainProgram = "foo";
    license = licenses.asl20;
  };
}
