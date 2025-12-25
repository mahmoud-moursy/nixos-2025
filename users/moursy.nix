{ pkgs, ... }:
{
  users.users.moursy.hashedPasswordFile = "${passwords/moursy.secret}";

  users.users.moursy = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.fish;
  };

  programs.bash.enable = true;
  programs.fish.enable = true;

  home-manager.users.moursy = ./home/moursy.nix;
}
