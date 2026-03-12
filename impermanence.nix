{ lib, ... }:
{
  boot.initrd.postMountCommands = lib.mkAfter ''
      		zfs rollback -r zroot/local/root@blank
    	'';

  fileSystems."/persist" = {
    device = "zroot/local/persist";
    fsType = "zfs";
    neededForBoot = true;
  };

  environment.persistence."/persist" = {
    enable = true; # NB: Defaults to true, not needed
    hideMounts = true;
    directories = [
      "/etc/nixos"
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/var/lib/sbctl"
      "/etc/NetworkManager/system-connections"
      {
        directory = "/var/lib/colord";
        user = "colord";
        group = "colord";
        mode = "u=rwx,g=rx,o=";
      }
    ];
    files = [
      "/etc/machine-id"
    ];
  };
}
