# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs,... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      #./david.nix
    ];
  # nixos unstable
  nix = {
    package = pkgs.nixUnstable; # or versioned attributes like nix_2_4
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
   };
  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    grub = {
        enable = true;
        version = 2;
        efiSupport = true;
        device = "nodev";
        useOSProber = true;
        splashImage = ./dotfiles/i3/atp.png;
        };
    #systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    };
  boot.supportedFilesystems = [ "ntfs" ];
  networking.networkmanager.enable = true;
  users.users.david = {
    isNormalUser = true;
    home = "/home/david";
    shell = pkgs.zsh;
    description = "David Lewis";
    extraGroups = [ "wheel" "networkmanager" "audio" "video"];
  };
  
  networking.hostName = "nixos"; # Define your hostname.
  time.timeZone = "America/New_York";

  hardware.bluetooth.enable = true;
  hardware.opengl.enable = true;

  networking.useDHCP = false;
  networking.interfaces.enp0s31f6.useDHCP = true;
  networking.interfaces.wlp82s0.useDHCP = true;
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
   
    
    displayManager = {
        defaultSession = "none+i3";
        lightdm = {
            enable = true;
            background = ./dotfiles/i3/atp.png;
            greeters.gtk = {
                enable = true;
                theme.name = "Nordic";
                theme.package = pkgs.nordic;
            };
        };
    };

    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
    };
    desktopManager.gnome.enable = true;
  };
  environment.gnome.excludePackages = [ pkgs.gnome.cheese pkgs.gnome-photos pkgs.gnome.gnome-music pkgs.gnome.gnome-terminal pkgs.gnome.gedit pkgs.epiphany pkgs.evince pkgs.gnome.gnome-characters pkgs.gnome.totem pkgs.gnome.tali pkgs.gnome.iagno pkgs.gnome.hitori pkgs.gnome.atomix pkgs.gnome-tour  pkgs.gnome.geary ];
   services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", MODE="0666", RUN+="${pkgs.coreutils}/bin/chmod a+w /sys/class/backlight/%k/brightness"
  '';

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  #sound.enable = false;
  hardware.pulseaudio.enable = false;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.jane = {
  #   isNormalUser = true;
  #   extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  # };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  services.emacs.enable = true;
  services.emacs.package = pkgs.emacsGcc;
  nixpkgs.overlays = [
    inputs.emacs-overlay.overlay
  ];
  nixpkgs.config = {
      packageOverrides = pkgs: rec {
        polybar = pkgs.polybar.override {
          pulseSupport = true;
          i3GapsSupport = true;
        };
      };
    };
  environment.systemPackages = with pkgs; [
     vim
     wget
     firefox
     git
     kitty
     feh
     polybar
     rofi
     flameshot
     zsh
     gcc
     nodejs
     unzip
    ((emacsPackagesNgGen emacsGcc).emacsWithPackages (epkgs: [
          epkgs.vterm
        ]))

    (aspellWithDicts (dicts: with dicts; [ en en-computers en-science ]))
     hunspell
     hunspellDicts.en_US
     python39
     xorg.xbacklight
     pamixer
     acpid
     dunst
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
     alsa-utils
     polkit_gnome
   ];
  programs.zsh.enable = true;
  # fonts
  fonts.enableDefaultFonts = true;
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "JetBrainsMono" ]; })
  siji ];
  fonts.fontconfig = {
    defaultFonts = {
      serif = [ "JetBrainsMono" ];
      sansSerif = [ "JetBrainsMono" ];
      monospace = [ "JetBrainsMono" ];
    };
  };
  
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    services.printing.enable = true;
    services.printing.drivers = [pkgs.hplip];
    services.avahi.enable = true;
    services.avahi.nssmdns = true;

  services.autorandr.enable = true;
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?

}

