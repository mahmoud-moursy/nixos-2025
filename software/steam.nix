{ pkgs, ... }: {
    programs.steam.enable = true;
    programs.steam.gamescopeSession.enable = true;    
    
    programs.gamescope.enable = true;
    programs.gamescope.capSysNice = true;

    programs.java.enable = true;
    programs.steam.extraPackages = [ pkgs.jdk ];

    programs.appimage.enable = true;
    programs.appimage.binfmt = true;
}
