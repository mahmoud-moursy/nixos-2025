{ pkgs, inputs, lib, ... }: {
  services.karakeep.enable = true;
  services.karakeep.extraEnvironment = {
    PORT = "3000";
    NEXTAUTH_URL = "https://local.moursy.org/karakeep/";
    NEXTAUTH_SECRET = lib.fileContents "${inputs.service-passwords}/karakeep-secret.password";
  };
  services.caddy.virtualHosts."local.moursy.org" = {
    extraConfig = ''
        redir /karakeep /karakeep/

        handle_path /karakeep/* {
          reverse_proxy localhost:3000
        }
      '';
  };
}
