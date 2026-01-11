{pkgs ? import <nixpkgs> {}}: {
  audiorelay = pkgs.callPackage ./audiorelay {};
  cam = pkgs.callPackage ./cam {};
  cheat = pkgs.callPackage ./cheat {};
  clone = pkgs.callPackage ./clone {};
  duck = pkgs.callPackage ./duck {};
  ix = pkgs.callPackage ./ix {};
  myip = pkgs.callPackage ./myip {};
  open = pkgs.callPackage ./open {};
  scratch = pkgs.callPackage ./scratch {};
  urlencode = pkgs.callPackage ./urlencode {};
  yank = pkgs.callPackage ./yank {};
}
