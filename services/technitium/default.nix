{ pkgs, lib, ... }: {
  
    systemd.services.technitium-dns-server = {
      description = "Technitium DNS Server";
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];

      serviceConfig = {
        ExecStart = "${pkgs.technitium-dns-server}/bin/technitium-dns-server /var/lib/technitium/config";

        DynamicUser = true;

        StateDirectory = "technitium";
        LogsDirectory = "technitium";
        CacheDirectory = "technitium";

        WorkingDirectory = "/var/lib/technitium";
        ReadWritePaths = "/var/lib/technitium /var/log/technitium /var/cache/technitium";

        Restart = "always";
        RestartSec = 10;
        TimeoutStopSec = 10;
        KillSignal = "SIGINT";

        # Harden the service
        LockPersonality = true;
        NoNewPrivileges = true;
        PrivateDevices = true;
        PrivateMounts = true;
        PrivateTmp = true;
        ProtectClock = true;
        ProtectControlGroups = true;
        ProtectHome = true;
        ProtectHostname = true;
        ProtectKernelLogs = true;
        ProtectKernelModules = true;
        ProtectKernelTunables = true;
        ProtectSystem = "strict";
        RemoveIPC = true;
        RestrictAddressFamilies = "AF_INET AF_INET6 AF_UNIX AF_NETLINK";
        RestrictNamespaces = true;
        RestrictRealtime = true;
        RestrictSUIDSGID = true;

        AmbientCapabilities = [ "CAP_NET_BIND_SERVICE" ];
        CapabilityBoundingSet = [ "CAP_NET_BIND_SERVICE" ];
      };
    };


  services.caddy.virtualHosts."lan.moursy.org" = {
    extraConfig = ''
      redir /technitium /technitium/ 308
      
      handle_path /technitium/* {
        reverse_proxy 127.0.0.1:5380
      }
    '';
  };
}
