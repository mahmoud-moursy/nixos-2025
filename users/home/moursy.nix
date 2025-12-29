{ pkgs, inputs, ... }:
{
  imports = [ ];

  home.packages = [
    pkgs.git
    pkgs.zed-editor-fhs
    pkgs.nixd
    pkgs.nil
    pkgs.nixfmt-rfc-style
    pkgs.devenv
    pkgs.keepassxc
    
    pkgs.gnome-system-monitor
    
    pkgs.thunderbird
    
    pkgs.noto-fonts
    pkgs.noto-fonts-cjk-sans
    pkgs.noto-fonts-cjk-serif
    pkgs.noto-fonts-color-emoji
    pkgs.unifont
    
    inputs.polypane.packages.x86_64-linux.polypane
  ];
  
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-cosmic ];
  xdg.portal.config.common.default = "*";
  
  fonts.fontconfig.enable = true;

  programs.git.enable = true;
  programs.git = {
    settings = {
      user.email = "bageliq@protonmail.com";
      user.name = "Mahmoud Moursy";
      init.defaultBranch = "main";
    };
  };

  programs.vivaldi.enable = true;

  programs.direnv.enable = true;
  programs.zoxide.enable = true;

  programs.bash.enable = true;
  programs.fish.enable = true;

  home.shell.enableFishIntegration = true;
  home.shell.enableBashIntegration = true;

  programs.nh.enable = true;
  programs.nh.clean.enable = true;
  programs.nh.clean.extraArgs = "--keep-since 4d";
  programs.nh.flake = "path:/etc/nixos";

  services.syncthing.enable = true;

  nix.settings.extra-substituters = [ "https://devenv.cachix.org" ];
  nix.settings.extra-trusted-public-keys = [
    "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
  ];

  home.stateVersion = "25.11";
}
