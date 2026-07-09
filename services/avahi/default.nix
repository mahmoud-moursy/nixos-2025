{
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = false;
    denyInterfaces = [ "docker0" ];
  };
}
