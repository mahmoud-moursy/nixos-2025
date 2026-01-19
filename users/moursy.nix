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
    ]; 
    shell = pkgs.fish;
  };

  programs.bash.enable = true;
  programs.fish.enable = true;
  documentation.man.generateCaches = false; # Building is unbearably slow otherwise

  home-manager.users.moursy = (import ./home/moursy.nix all);
}
