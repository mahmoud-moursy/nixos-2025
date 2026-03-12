{ pkgs, lib, ... }: {
  boot.blacklistedKernelModules = [ "r8169" ]; # Causes breakage for RTL 8125 LAN specifically

  boot.extraModulePackages = [ pkgs.r8125 ];
  boot.kernelModules = [ "r8125" ];
}
