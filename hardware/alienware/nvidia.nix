{ lib, pkgs, ... }: {
  # The open source driver does not support Pascal GPUs.
  hardware.nvidia.open = false;
  hardware.nvidia.package = lib.mkDefault config.boot.kernelPackages.nvidiaPackages.legacy_580;


  boot.kernelParams = [
    "mem_sleep_default=deep"
    "nvidia.NVreg_UsePageAttributeTable=1"
    "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
  ];
  boot.kernelModules = [
    "nvidia"
    "nvidia_uvm"
    "nvidia_modeset"
  ];

  services.xserver.videoDrivers = [ "nvidia" ];
}