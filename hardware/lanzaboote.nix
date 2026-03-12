{ pkgs, lib, ... }: {
    environment.systemPackages = [ pkgs.sbctl ];
    
    boot.lanzaboote.enable = true;
    boot.lanzaboote.pkiBundle = "/var/lib/sbctl";
}