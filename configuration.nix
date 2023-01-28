# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:
{
  imports =
    [
    ];
  # nixos unstable
  nix.package = pkgs.nixUnstable;
  nix.extraOptions = "experimental-features = nix-command flakes";
  nix.settings.auto-optimise-store = true;
  nix.settings.substituters = [
    "https://nix-community.cachix.org"
    "https://hyperland.cachix.org"
  ];
  nix.settings.trusted-public-keys = [
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
  ];
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    grub = {
      enable = true;
      version = 2;
      efiSupport = true;
      device = "nodev";
      splashImage = "${inputs.dotfiles}/i3/atp.png";
    };
    #systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
  boot.supportedFilesystems = [ "ntfs" ];
  networking.networkmanager.enable = true;
  programs.nm-applet =
    {
      enable = true;
      indicator = true;
    };
  services.samba.enable = true;

  time.timeZone = "America/New_York";

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  services.gnome.at-spi2-core.enable = true;

  xdg.icons.enable = true;

  # needed for some apps
  hardware.opengl.enable = true;

  # disables DHCP
  networking.useDHCP = false;
  networking.interfaces.enp0s31f6.useDHCP = true;
  #networking.interfaces.wlp82s0.useDHCP = true;

  # networking
  hardware.acpilight.enable = true;
  services.acpid.enable = true;
  networking.dhcpcd.enable = false;

  # window manager config
  nixpkgs.config.allowUnfree = true;
  services.xserver = {
    enable = true;
    dpi = 96;
    desktopManager = {
      xterm.enable = false;
    };

    screenSection = ''Option "FlatPanelProperties" "Dithering=Disabled"'';
    displayManager = {
      defaultSession = "hyprland";
      lightdm = {
        #enable = true;
        background = "${inputs.dotfiles}/i3/atp.png";
        greeters.gtk = {
          enable = true;
          theme.name = "Nordic";
          theme.package = pkgs.nordic;
        };
      };
      gdm.enable = true;
    };

    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
    };
    desktopManager = {
      gnome.enable = false;
      xfce = {
        enable = true;
        noDesktop = true;
        enableXfwm = false;
      };
    };
  };
  #services.autorandr.enable = true;
  environment.gnome.excludePackages = [ pkgs.gnome.cheese pkgs.gnome-photos pkgs.gnome.gnome-music pkgs.gnome.gnome-terminal pkgs.gnome.gedit pkgs.epiphany pkgs.evince pkgs.gnome.gnome-characters pkgs.gnome.totem pkgs.gnome.tali pkgs.gnome.iagno pkgs.gnome.hitori pkgs.gnome.atomix pkgs.gnome-tour pkgs.gnome.geary ];
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", MODE="0666", RUN+="${pkgs.coreutils}/bin/chmod a+w /sys/class/backlight/%k/brightness"
  '';

  hardware.pulseaudio.enable = false;
  nixpkgs.config = {
    packageOverrides = pkgs: rec {
      polybar = pkgs.polybar.override {
        pulseSupport = true;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    wireshark
    termshark
    gnome-icon-theme
    papirus-icon-theme
    vim
    wget
    firefox
    git
    git-lfs
    kitty
    feh
    gcc
    nodejs
    unzip
    socat

    (aspellWithDicts (dicts: with dicts; [ en en-computers en-science ]))
    hunspell
    hunspellDicts.en_US
    xorg.xbacklight
    pamixer
    acpid
    libnotify
    gnupg
    pinentry
    cmake
    gnumake
    libtool
    binutils
    gotop
    coreutils
    fd
    clang
    ripgrep
    ripgrep-all
    alsa-utils
    polkit_gnome
    gum
    xdg-utils
    exfat
  ];
  programs.wireshark.enable = true;
  programs.zsh.enable = true;
  programs.light.enable = true;
  # fonts
  fonts.enableDefaultFonts = true;
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "JetBrainsMono" ]; })
    siji
    corefonts
    emacs-all-the-icons-fonts
  ];
  fonts.fontconfig = {
    defaultFonts = {
      serif = [ "JetBrainsMono Nerd Font Mono" ];
      sansSerif = [ "JetBrainsMono Nerd Font Mono" ];
      monospace = [ "JetBrainsMono Nerd Font Mono" ];
    };
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    #extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
  #services.printing.enable = true;
  #services.printing.drivers = [ pkgs.hplip ];
  services.avahi.enable = true;
  services.avahi.nssmdns = true;
  services.flatpak.enable = true;
  virtualisation.docker.enable = true;
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.guest.enable = true;

  hardware.opentabletdriver.enable = true;
  hardware.opentabletdriver.daemon.enable = true;
  services.gvfs.enable = true;


  nixpkgs.config.permittedInsecurePackages = [
    "electron-12.2.3"
  ];
  system.stateVersion = "22.11"; # Did you read the comment?

}
