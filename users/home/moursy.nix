{ pkgs, ... }:
{
  imports = [ ];

  home.packages = with pkgs; [
    git
    zed-editor-fhs
    nixd
    nil
    nixfmt-rfc-style
    devenv
    keepassxc
  ];
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-cosmic ];
  xdg.portal.configPackages = [ pkgs.xdg-desktop-portal-cosmic ];

  programs.git.enable = true;
  programs.git = {
    extraConfig = {
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
