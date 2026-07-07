{ pkgs, lib, ... }: {
  services.vaultwarden = {
    enable = true;
    domain = "https://local.moursy.org/vaultwarden";
    config = {      
      ROCKET_ADDRESS = "127.0.0.1";
      ROCKET_PORT = 8222;   
    };
  };

  services.caddy.virtualHosts."local.moursy.org" = {
    extraConfig = ''
      handle_path /vaultwarden* {
        reverse_proxy 127.0.0.1:8222
      }
      '';
  };
}
