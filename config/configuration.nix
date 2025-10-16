# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ pkgs, ... }:
{
  # enable flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  #unfree apps
  nixpkgs.config.allowUnfree = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "davidnix";
  networking.networkmanager.enable = true;
  # may need to set MTU packet size on spectrum wifi networks
  # No idea really what is going on with it. Could be a dns issue
  # try nslookup google.com (pkgs.bind)

  time.timeZone = "America/New_York";

  services.xserver.enable = true;

  services.xserver.displayManager.gdm.enable = true;
  #services.desktopManager.plasma6.enable = true;
  #programs.ssh.askPassword = pkgs.lib.mkForce "${pkgs.seahorse.out}/libexec/seahorse/ssh-askpass";
  services.xserver.desktopManager.gnome.enable = true;
  programs.kdeconnect = {
    enable = true;
  };
  programs.hyprland.enable = true;

  # collect garbage
  nix.optimise.automatic = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  #bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # enable shell
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.nushell;

  system.stateVersion = "24.11"; # DONTCHANGE

  # asterisk keyboard integration with javelin steno
  services.udev.extraRules = ''
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="9000", ATTRS{idProduct}=="400d", MODE="0666"
    SUBSYSTEM=="input", ATTRS{name}=="8Bitdo SN30 Pro", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"
  '';

  ## drawing tablets (no bluetooth support)
  hardware.opentabletdriver.enable = true;

  ## corsair rgb keyboard (hopefully dropping this soon)
  hardware.ckb-next.enable = true;

}
