{ pkgs, ... }: {
    programs.steam.enable = true;
    programs.steam.gamescopeSession.enable = true;    
    
    programs.gamescope.enable = true;
    programs.gamescope.capSysNice = true;

    programs.java.enable = true;
    programs.java.package = pkgs.jdk25;
    
    programs.steam.extraPackages = [ pkgs.jdk pkgs.jdk25 ];

    programs.appimage.enable = true;
    programs.appimage.binfmt = true;
}
