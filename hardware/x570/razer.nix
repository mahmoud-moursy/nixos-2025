{ pkgs, ... }: {
  hardware.openrazer.enable = true;
  environment.systemPackages = [ pkgs.openrazer-daemon pkgs.razergenie ];
}
