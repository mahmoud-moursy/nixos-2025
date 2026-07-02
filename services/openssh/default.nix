{ lib, ... }: {
  services.openssh = {
   enable = true;
   settings.PermitRootLogin = "no";
   settings.PasswordAuthentication = lib.mkDefault false;
  };
}