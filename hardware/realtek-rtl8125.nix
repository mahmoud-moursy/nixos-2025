{ pkgs, lib, ... }: {
  boot.blacklistedKernelModules = [ "r8169" ]; # Causes breakage for RTL 8125 LAN specifically

  boot.extraModulePackages = [ pkgs.linuxPackages.r8125 ];
  boot.kernelModules = [ "r8125" ];
}
