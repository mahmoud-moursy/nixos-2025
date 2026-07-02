{
  services.avahi = {
    publish = {
      enable = true;
      userServices = true;
      addresses = true;
      workstation = true;
    };
    openFirewall = true;
  };
}