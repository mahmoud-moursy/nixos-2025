all@{ pkgs, inputs, ... }:
{
  users.users.moursy.hashedPasswordFile = "${inputs.user-passwords}/moursy.secret";

  users.users.moursy = {
    description = "Mahmoud Moursy";
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "docker"
      "openrazer"
    ]; 
    shell = pkgs.fish;
  };

  programs.bash.enable = true;
  programs.fish.enable = true;

  home-manager.users.moursy = (import ./home/moursy.nix all);
}
