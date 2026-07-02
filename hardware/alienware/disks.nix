{

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/eb8dc1b0-8e86-4695-ac8a-a23e348c6203";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/nvme0n1p1";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };
}