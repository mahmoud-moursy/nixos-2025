{
  networking.interfaces.enp61s0.ipv4.addresses = [ {
    address = "192.168.1.5";
    prefixLength = 24;
  } ];
  networking.interfaces.enp61s0.useDHCP = true;
}
