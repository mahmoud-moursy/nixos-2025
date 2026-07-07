{ inputs, ... }: {
  services.syncthing = {
    guiAddress = "127.0.0.1:8384";
    openDefaultPorts = false;
  };

  services.caddy.virtualHosts."local.moursy.org" = {
    extraConfig = ''
      redir /syncything /syncthing/ 308
      
      handle_path /syncthing/* {
        reverse_proxy 127.0.0.1:8384 {        
          header_up Host {upstream_hostport}
        }
      }
    '';
  };
}
