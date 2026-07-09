{ lib, pkgs, config, ... }: {
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
  
  # The open source driver does not support Pascal GPUs.
  hardware.nvidia.open = false;
  hardware.nvidia.package = lib.mkDefault config.boot.kernelPackages.nvidiaPackages.legacy_580;

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
