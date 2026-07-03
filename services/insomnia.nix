{
  # Prevent autosleep
  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;

  services.logind.settings.Login.HandleLidSwitch = "ignore";
  services.logind.settings.Login.HandleLidSwitchExternalPower = "ignore";
  services.logind.settings.Login.HandleLidSwitchDocked = "ignore";

  services.logind.settings.Login.HandlePowerKey = "ignore";
  services.logind.settings.Login.HandleRebootKey = "ignore";
  services.logind.settings.Login.HandleSuspendKey = "ignore";
  services.logind.settings.Login.HandleHibernateKey = "ignore";
}
