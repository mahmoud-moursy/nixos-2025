{ inputs, ... }: {
  services.syncthing = {
    guiAddress = "0.0.0.0:8384";
    openDefaultPorts = true;
  };
}