{pkgs, ...}: {
  imports = [
    ./shodan
    ./zap
  ];

  home.packages = with pkgs; [
    amass
    anew
    ffuf
    httpx
    nmap
    subfinder
  ];
}
