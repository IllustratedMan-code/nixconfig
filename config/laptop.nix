{...}:
{

  services.logind.settings.Login = {
    handleLidSwitch = "suspend";
    HandleLidSwitchedDocked = "ignore";
    HandleListSwitchExternalPower = "suspend";
  };
  # this changed in 25.11
  # services.logind.lidSwitch = "suspend";
  # services.logind.lidSwitchDocked = "ignore";
  # services.logind.lidSwitchExternalPower = "suspend";
  ## power profiles daemon (installed with gnome) should do this by default
  # services.auto-cpufreq = {
  #   enable = true;
  #   settings = {
  #     battery = {
  #       governor = "powersave";
  #       turbo = "never";
  #     };
  #     charger = {
  #       governor = "performance";
  #       turbo = "auto";
  #     };
  #   };
  # };
}
