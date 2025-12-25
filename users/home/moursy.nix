{ pkgs, impermanence, ... }:
{
  imports = [ ];

  home.packages = with pkgs; [
    git
    zed-editor-fhs
    nixd
    nil
  ];
  programs.firefox.enable = true;

  home.stateVersion = "25.11";
}
