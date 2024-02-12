{
  services.factorio = {
    enable = true;
    game-name = "Factorix";
    description = "Factorix";
    lan = true;
    public = false;
    saveName = "factorix";
    port = 34197;
    extraSettings = {
      admins = ["averagebit"];
    };
    bind = "0.0.0.0";
  };

  networking.firewall.allowedTCPPorts = [34197];
}
