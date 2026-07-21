{
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    denyInterfaces = [ "docker0" "lo" ];
  };
}
