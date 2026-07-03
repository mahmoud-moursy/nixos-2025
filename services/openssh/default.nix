{ lib, ... }: {
  services.openssh = {
   enable = true;
   openFirewall = lib.mkDefault false;
   settings.PermitRootLogin = "no";
   settings.PasswordAuthentication = lib.mkDefault false;
  };
}
