{ pkgs, lib, ... }: {
  services.caddy.enable = true;
  services.caddy.email = "business.mahmoud.m@icloud.com";
  services.caddy.package = pkgs.caddy.withPlugins {
    plugins = [ "github.com/caddy-dns/cloudflare@v0.2.4"];
    hash = "sha256-hEHgAG0F0ozHRAPuxEqLyTATBrE+pajeXDiSNwniorg=";
  };
  services.caddy.environmentFile = ../passwords/caddy.env;

  services.caddy.virtualHosts."local.moursy.org" = {
    extraConfig = ''
      @external-address {
        not remote_ip 10.0.0.0/8 172.16.0.0/12 192.168.0.0/16 127.0.0.1/32 fc00::/7 fe80::/10 ::1/128
      }

      handle @external-address {
        respond "Please connect from an internal IP (forbidden)" 403
      }

      tls {
        dns cloudflare {env.CLOUDFLARE_API_KEY}
      }
      '';
  };
}
