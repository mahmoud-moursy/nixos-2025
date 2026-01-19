{ config, ... }:
{
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;
  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.open = true;
  hardware.nvidia.powerManagement.enable = true;
  hardware.nvidia.powerManagement.finegrained = false;
  hardware.nvidia-container-toolkit.enable = true;

  boot.kernelParams = [ "mem_sleep_default=deep" "nvidia.NVreg_UsePageAttributeTable=1" "nvidia.NVreg_PreserveVideoMemoryAllocations=1" "video=DP-1:D" "video=DP-3:D" ];
  boot.kernelModules = [ "nvidia" "nvidia_uvm" "nvidia_modeset" ];

  services.xserver.videoDrivers = [ "nvidia" ];
}
