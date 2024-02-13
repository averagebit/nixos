{pkgs, ...}: {
  imports = [
    ./shodan
    ./zap
  ];

  home.packages = with pkgs; [
    amass
    anew
    ffuf
    holeho
    httpx
    nmap
    subfinder
  ];
}
