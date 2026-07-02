{inputs, ... }: {
  services.syncthing = {
    enable = true;
    guiPasswordFile = "${inputs.service-passwords}/syncthing-password.secret";
    settings.gui.user = "mahmoud";
  };
}
