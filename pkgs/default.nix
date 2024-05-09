{pkgs ? import <nixpkgs> {}}: {
  cheat = pkgs.callPackage ./cheat {};
  clone = pkgs.callPackage ./clone {};
  ix = pkgs.callPackage ./ix {};
  myip = pkgs.callPackage ./myip {};
  sst = pkgs.callPackage ./sst {};
  urlencode = pkgs.callPackage ./urlencode {};
  yank = pkgs.callPackage ./yank {};
}
