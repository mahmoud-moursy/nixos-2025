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
      tls {
        dns cloudflare {env.CLOUDFLARE_API_KEY}
      }
      '';
  };
}
