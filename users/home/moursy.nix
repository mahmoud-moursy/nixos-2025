{ pkgs, inputs, lib, config, ... }:
{
  imports = [ ];

  home.packages = [
    pkgs.git
    pkgs.gh
    
    pkgs.nixd
    pkgs.nil
    pkgs.nixfmt

    pkgs.deploy-rs
  ] ++ lib.optionals config.services.xserver.enable [
    pkgs.zed-editor-fhs

    pkgs.jetbrains.webstorm
    pkgs.jetbrains.datagrip
    pkgs.jetbrains.dataspell
    pkgs.jetbrains.idea

    pkgs.gnome-system-monitor
    
    pkgs.noto-fonts
    pkgs.noto-fonts-cjk-sans
    pkgs.noto-fonts-cjk-serif
    pkgs.noto-fonts-color-emoji
    pkgs.unifont
  ];
  
  # xdg.portal.enable = true;
  # xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-cosmic ];
  # xdg.portal.config.common.default = [ "cosmic" "*" ];
  
  fonts.fontconfig.enable = true;

  programs.git.enable = true;
  programs.git = {
    settings = {
      user.email = "business.mahmoud.m@icloud.com";
      user.name = "Mahmoud Moursy";
      init.defaultBranch = "main";
    };
  };

  programs.devenv.enable = true;
  programs.devenv.enableFishIntegration = true;
  
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

  home.stateVersion = "25.11";
}
