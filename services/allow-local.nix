{
  networking.firewall.extraInputRules = ''
      ip6 saddr { fe80::/10, fc00::/7                        } accept comment "Allow Local Access (IPv6)"
      ip  saddr { 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16  } accept comment "Allow Local Access (IPv4)"
    '';
}
