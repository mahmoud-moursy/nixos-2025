{ pkgs, lib, ... }: {
  # Enable the X11 windowing system.
  services.xserver.enable = true;
  xdg.portal.enable = true;
  # xdg.portal.extraPortals = [
  #   pkgs.xdg-desktop-portal-cosmic
  #   pkgs.xdg-desktop-portal-gtk
  # ];
  services.flatpak.enable = true;

  # Enable COSMIC
  services.displayManager.cosmic-greeter.enable = true;
  services.desktopManager.cosmic.enable = true;
  services.system76-scheduler.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Configure keymap in X11
  services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    jack.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    wireplumber.enable = true;
    extraConfig.pipewire = {
      context.properties = {
        #defautlt.allowed-rates = [ 192000 48000 44100 ];
        defautlt.clock.allowed-rates = [
          384000
          192000
          96000
          48000
          44100
        ];
        default.clock.rate = 384000;
        default.clock.quantum = 32;
        default.clock.min-quantum = 32;
        default.clock.max-quantum = 32;
      };
    };
  };
}
