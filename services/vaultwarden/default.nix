{ pkgs, lib, ... }: {
  services.vaultwarden = {
    enable = true;
    config = {
      DOMAIN="https://lan.moursy.org/vaultwarden/";
      ROCKET_ADDRESS = "127.0.0.1";
      ROCKET_PORT = 8222;   
    };
  };

  services.caddy.virtualHosts."lan.moursy.org" = {
    extraConfig = ''
      redir /vaultwarden /vaultwarden/ 308
      
      handle /vaultwarden/* {
        reverse_proxy 127.0.0.1:8222
      }
      '';
  };
}
