{
  config,
  pkgs,
  lib,
  ...
}:
{
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;
  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.open = true;
  hardware.nvidia.powerManagement.enable = true;
  hardware.nvidia.powerManagement.finegrained = false;
  hardware.nvidia-container-toolkit.enable = true;

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

  nix.settings = rec {
    trusted-substituters = [
      "https://cache.nixos-cuda.org"
      "https://cuda-maintainers.cachix.org"
      "https://cache.flox.dev"
    ];
    extra-substituters = trusted-substituters;
    substituters = trusted-substituters;
    extra-trusted-substituters = trusted-substituters;
    trusted-public-keys = [
      "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
      "flox-cache-public-1:7F4OyH7ZCnFhcze3fJdfyXYLQw/aV7GEed86nQ7IsOs="
    ];
    extra-trusted-public-keys = trusted-public-keys;
  };

  nixpkgs.config.cudaSupport = true;
  nixpkgs.config.cudaForwardCompat = true;

  programs.nix-ld.libraries = with pkgs; [
    cudaPackages.cudatoolkit
    cudaPackages.cudnn
    cudaPackages.libcublas
    cudaPackages.cuda_cudart
    linuxPackages.nvidia_x11
  ];
}
