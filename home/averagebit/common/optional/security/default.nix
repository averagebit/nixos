{pkgs, ...}: {
  imports = [
    ./shodan
    ./zap
  ];

  home.packages = with pkgs; [
    amass
    anew
    ffuf
    holehe
    httpx
    nmap
    subfinder
  ];
}
