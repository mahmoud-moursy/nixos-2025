{
  services.openssh = {
   settings.PasswordAuthentication = true;
  };

  networking.firewall.extraInputRules = ''
      ip saddr { 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16 } tcp dport 22 accept comment "SSH Local Access"
      ip6 saddr { fd00::/8, fe80::/10 } tcp dport 22 accept comment "SSH Local Access"
    '';
}
